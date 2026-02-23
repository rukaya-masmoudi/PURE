PRAGMA foreign_keys = ON;

-- =========================
-- DROP (safe rebuild)
-- =========================
DROP VIEW IF EXISTS v_portfolio_search_items;
DROP VIEW IF EXISTS v_reflection_signals;
DROP VIEW IF EXISTS v_ml_study_sessions;
DROP VIEW IF EXISTS v_calendar_day_activity;
DROP VIEW IF EXISTS v_day_metrics;

-- Life (drop first due to FKs)
DROP TABLE IF EXISTS EventMedia;
DROP TABLE IF EXISTS MediaAsset;
DROP TABLE IF EXISTS EventPost;
DROP TABLE IF EXISTS Post;
DROP TABLE IF EXISTS EventParticipation;
DROP TABLE IF EXISTS Role;
DROP TABLE IF EXISTS Contribution;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Venue;
DROP TABLE IF EXISTS Engagement;
DROP TABLE IF EXISTS EngagementType;
DROP TABLE IF EXISTS Organization;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Community;

-- Studies
DROP TABLE IF EXISTS SessionTag;
DROP TABLE IF EXISTS TopicTag;

DROP TABLE IF EXISTS PracticeResult;
DROP TABLE IF EXISTS StudySession;
DROP TABLE IF EXISTS Topic;

DROP TABLE IF EXISTS CertificationAttempt;
DROP TABLE IF EXISTS Certification;

DROP TABLE IF EXISTS Tag;

DROP TABLE IF EXISTS AttemptStatus;
DROP TABLE IF EXISTS PracticeResultType;
DROP TABLE IF EXISTS StudyStatus;
DROP TABLE IF EXISTS Visibility;

DROP TABLE IF EXISTS CertificationTier;
DROP TABLE IF EXISTS LearningLevel;

DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Provider;

DROP TABLE IF EXISTS ReflectionAnalysis;
DROP TABLE IF EXISTS Reflection;

-- =========================
-- CATALOGS
-- =========================

CREATE TABLE Provider (
  provider_id INTEGER PRIMARY KEY,
  name        TEXT NOT NULL UNIQUE,
  notes       TEXT
);

CREATE TABLE Category (
  category_id INTEGER PRIMARY KEY,
  name        TEXT NOT NULL UNIQUE,
  notes       TEXT
);

-- LearningLevel: for learning assets (modules/paths/applied skills)
CREATE TABLE LearningLevel (
  learning_level_id INTEGER PRIMARY KEY,
  name              TEXT NOT NULL UNIQUE,
  notes             TEXT
);

-- CertificationTier: for official certification tiers
CREATE TABLE CertificationTier (
  cert_tier_id INTEGER PRIMARY KEY,
  name         TEXT NOT NULL UNIQUE,
  notes        TEXT
);

CREATE TABLE Visibility (
  visibility_id INTEGER PRIMARY KEY,
  name          TEXT NOT NULL UNIQUE,
  notes         TEXT
);

CREATE TABLE StudyStatus (
  status_id INTEGER PRIMARY KEY,
  name      TEXT NOT NULL UNIQUE,
  notes     TEXT
);

CREATE TABLE PracticeResultType (
  result_type_id INTEGER PRIMARY KEY,
  name           TEXT NOT NULL UNIQUE,
  notes          TEXT
);

CREATE TABLE AttemptStatus (
  attempt_status_id INTEGER PRIMARY KEY,
  name              TEXT NOT NULL UNIQUE,
  notes             TEXT
);

CREATE TABLE Tag (
  tag_id      INTEGER PRIMARY KEY,
  name        TEXT NOT NULL UNIQUE,
  description TEXT
);

-- =========================
-- CORE: TOPICS + SESSIONS
-- =========================

-- Topic = learning unit (module/path/applied skill)
CREATE TABLE Topic (
  topic_id           INTEGER PRIMARY KEY,
  name               TEXT NOT NULL,

  provider_id        INTEGER NOT NULL,
  category_id        INTEGER NOT NULL,
  learning_level_id  INTEGER NOT NULL,

  visibility_id      INTEGER NOT NULL,
  created_at         TEXT NOT NULL,

  UNIQUE(name, provider_id),

  FOREIGN KEY (provider_id)       REFERENCES Provider(provider_id),
  FOREIGN KEY (category_id)       REFERENCES Category(category_id),
  FOREIGN KEY (learning_level_id) REFERENCES LearningLevel(learning_level_id),
  FOREIGN KEY (visibility_id)     REFERENCES Visibility(visibility_id)
);

CREATE INDEX idx_topic_provider   ON Topic(provider_id);
CREATE INDEX idx_topic_category   ON Topic(category_id);
CREATE INDEX idx_topic_visibility ON Topic(visibility_id);
CREATE INDEX idx_topic_level      ON Topic(learning_level_id);

-- StudySession = one real study block
CREATE TABLE StudySession (
  session_id        INTEGER PRIMARY KEY,
  topic_id          INTEGER NOT NULL,

  started_at        TEXT NOT NULL,
  ended_at          TEXT NOT NULL,
  duration_minutes  INTEGER NOT NULL CHECK(duration_minutes >= 0),

  difficulty        INTEGER CHECK(difficulty BETWEEN 1 AND 5),
  energy            INTEGER CHECK(energy BETWEEN 1 AND 5),
  notes             TEXT,

  visibility_id     INTEGER NOT NULL,
  status_id         INTEGER NOT NULL,

  created_at        TEXT NOT NULL DEFAULT (datetime('now')),

  -- Guardrail: time integrity
  CHECK (julianday(ended_at) >= julianday(started_at)),

  FOREIGN KEY (topic_id)      REFERENCES Topic(topic_id),
  FOREIGN KEY (visibility_id) REFERENCES Visibility(visibility_id),
  FOREIGN KEY (status_id)     REFERENCES StudyStatus(status_id)
);

CREATE INDEX idx_session_topic   ON StudySession(topic_id);
CREATE INDEX idx_session_started ON StudySession(started_at);
CREATE INDEX idx_session_vis     ON StudySession(visibility_id);
CREATE INDEX idx_session_status  ON StudySession(status_id);

-- PracticeResult = evaluated outcome tied to a StudySession (optional)
CREATE TABLE PracticeResult (
  result_id          INTEGER PRIMARY KEY,
  session_id         INTEGER NOT NULL,

  result_type_id     INTEGER NOT NULL,
  attempt_number     INTEGER NOT NULL CHECK(attempt_number >= 1),

  score              INTEGER CHECK(score BETWEEN 0 AND 100),
  attempt_status_id  INTEGER,

  feedback           TEXT,
  evidence_path      TEXT,

  visibility_id      INTEGER NOT NULL,
  created_at         TEXT NOT NULL DEFAULT (datetime('now')),

  FOREIGN KEY (session_id)        REFERENCES StudySession(session_id),
  FOREIGN KEY (result_type_id)    REFERENCES PracticeResultType(result_type_id),
  FOREIGN KEY (attempt_status_id) REFERENCES AttemptStatus(attempt_status_id),
  FOREIGN KEY (visibility_id)     REFERENCES Visibility(visibility_id)
);

CREATE INDEX idx_practice_session ON PracticeResult(session_id);
CREATE INDEX idx_practice_type    ON PracticeResult(result_type_id);

-- Tags (Topic-level + Session-level)
CREATE TABLE TopicTag (
  topic_id INTEGER NOT NULL,
  tag_id   INTEGER NOT NULL,
  PRIMARY KEY (topic_id, tag_id),
  FOREIGN KEY (topic_id) REFERENCES Topic(topic_id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id)   REFERENCES Tag(tag_id)   ON DELETE CASCADE
);

CREATE TABLE SessionTag (
  session_id INTEGER NOT NULL,
  tag_id     INTEGER NOT NULL,
  PRIMARY KEY (session_id, tag_id),
  FOREIGN KEY (session_id) REFERENCES StudySession(session_id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id)     REFERENCES Tag(tag_id)             ON DELETE CASCADE
);

-- Indexes for tag filtering / joins
CREATE INDEX idx_topictag_tag    ON TopicTag(tag_id);
CREATE INDEX idx_sessiontag_tag  ON SessionTag(tag_id);

-- =========================
-- CERTIFICATIONS
-- =========================

CREATE TABLE Certification (
  certification_id INTEGER PRIMARY KEY,

  code             TEXT NOT NULL UNIQUE,
  name             TEXT NOT NULL,

  provider_id      INTEGER NOT NULL,
  category_id      INTEGER NOT NULL,
  cert_tier_id     INTEGER NOT NULL,

  official_url     TEXT,
  created_at       TEXT NOT NULL DEFAULT (datetime('now')),

  FOREIGN KEY (provider_id)  REFERENCES Provider(provider_id),
  FOREIGN KEY (category_id)  REFERENCES Category(category_id),
  FOREIGN KEY (cert_tier_id) REFERENCES CertificationTier(cert_tier_id)
);

CREATE INDEX idx_cert_provider ON Certification(provider_id);
CREATE INDEX idx_cert_category ON Certification(category_id);
CREATE INDEX idx_cert_tier     ON Certification(cert_tier_id);

CREATE TABLE CertificationAttempt (
  attempt_id        INTEGER PRIMARY KEY,
  certification_id  INTEGER NOT NULL,

  attempt_number    INTEGER NOT NULL CHECK(attempt_number >= 1),
  exam_date         TEXT NOT NULL,

  attempt_status_id INTEGER NOT NULL,
  score             INTEGER CHECK(score BETWEEN 0 AND 1000),
  notes             TEXT,

  visibility_id     INTEGER NOT NULL,
  created_at        TEXT NOT NULL DEFAULT (datetime('now')),

  FOREIGN KEY (certification_id)  REFERENCES Certification(certification_id),
  FOREIGN KEY (attempt_status_id) REFERENCES AttemptStatus(attempt_status_id),
  FOREIGN KEY (visibility_id)     REFERENCES Visibility(visibility_id)
);

CREATE INDEX idx_cert_attempt_cert ON CertificationAttempt(certification_id);
CREATE INDEX idx_cert_attempt_date ON CertificationAttempt(exam_date);

-- =========================
-- LIFE LAYER (Impact Block)
-- =========================

-- Community = organizer / group
CREATE TABLE Community (
  community_id  INTEGER PRIMARY KEY,
  name          TEXT NOT NULL UNIQUE,
  description   TEXT,
  website_url   TEXT,
  visibility_id INTEGER NOT NULL,
  created_at    TEXT NOT NULL DEFAULT (datetime('now')),

  FOREIGN KEY (visibility_id) REFERENCES Visibility(visibility_id)
);

CREATE INDEX idx_community_visibility ON Community(visibility_id);

-- City = reusable location dimension
CREATE TABLE City (
  city_id  INTEGER PRIMARY KEY,
  name     TEXT NOT NULL,
  region   TEXT,
  country  TEXT NOT NULL,
  UNIQUE(name, country)
);

-- Organization = companies, educational centers, etc.
CREATE TABLE Organization (
  organization_id INTEGER PRIMARY KEY,
  name            TEXT NOT NULL UNIQUE,
  org_type        TEXT NOT NULL, -- education / company / other
  website_url     TEXT,
  city_id         INTEGER,
  description     TEXT,
  visibility_id   INTEGER NOT NULL,
  created_at      TEXT NOT NULL DEFAULT (datetime('now')),

  FOREIGN KEY (city_id)      REFERENCES City(city_id),
  FOREIGN KEY (visibility_id) REFERENCES Visibility(visibility_id)
);

CREATE INDEX idx_org_city       ON Organization(city_id);
CREATE INDEX idx_org_visibility ON Organization(visibility_id);

-- EngagementType = catalog of engagement nature (education, work, volunteering, project, ...)
CREATE TABLE EngagementType (
  engagement_type_id INTEGER PRIMARY KEY,
  name               TEXT NOT NULL UNIQUE,
  notes              TEXT
);

-- Engagement = long-running relationships with organizations or communities
-- (education, work, volunteering, projects)
CREATE TABLE Engagement (
  engagement_id      INTEGER PRIMARY KEY,
  engagement_type_id INTEGER NOT NULL,

  organization_id    INTEGER,
  community_id       INTEGER,

  title              TEXT NOT NULL,
  started_on         TEXT NOT NULL, -- date (YYYY-MM-DD)
  ended_on           TEXT,          -- nullable
  is_current         INTEGER NOT NULL DEFAULT 0 CHECK(is_current IN (0,1)),

  city_id            INTEGER,
  description        TEXT,

  visibility_id      INTEGER NOT NULL,
  created_at         TEXT NOT NULL DEFAULT (datetime('now')),

  -- exactly one of organization_id or community_id must be non-null
  CHECK (
    (organization_id IS NOT NULL AND community_id IS NULL) OR
    (organization_id IS NULL AND community_id IS NOT NULL)
  ),

  FOREIGN KEY (engagement_type_id) REFERENCES EngagementType(engagement_type_id),
  FOREIGN KEY (organization_id)    REFERENCES Organization(organization_id),
  FOREIGN KEY (community_id)       REFERENCES Community(community_id),
  FOREIGN KEY (city_id)            REFERENCES City(city_id),
  FOREIGN KEY (visibility_id)      REFERENCES Visibility(visibility_id)
);

CREATE INDEX idx_engagement_type   ON Engagement(engagement_type_id);
CREATE INDEX idx_engagement_org    ON Engagement(organization_id);
CREATE INDEX idx_engagement_comm   ON Engagement(community_id);
CREATE INDEX idx_engagement_dates  ON Engagement(started_on, ended_on);
CREATE INDEX idx_engagement_current ON Engagement(is_current);

-- Venue = reusable physical place
CREATE TABLE Venue (
  venue_id  INTEGER PRIMARY KEY,
  name      TEXT NOT NULL,
  address   TEXT,
  city_id   INTEGER NOT NULL,
  notes     TEXT,
  UNIQUE(name, city_id),

  FOREIGN KEY (city_id) REFERENCES City(city_id)
);

CREATE INDEX idx_venue_city ON Venue(city_id);

-- Event = occurrence linked to Community + Venue
CREATE TABLE Event (
  event_id      INTEGER PRIMARY KEY,
  name          TEXT NOT NULL,
  community_id  INTEGER NOT NULL,
  venue_id      INTEGER NOT NULL,

  starts_at     TEXT NOT NULL,
  ends_at       TEXT,
  language      TEXT,
  external_url  TEXT,

  visibility_id INTEGER NOT NULL,
  created_at    TEXT NOT NULL DEFAULT (datetime('now')),

  CHECK (ends_at IS NULL OR julianday(ends_at) >= julianday(starts_at)),

  FOREIGN KEY (community_id)  REFERENCES Community(community_id),
  FOREIGN KEY (venue_id)      REFERENCES Venue(venue_id),
  FOREIGN KEY (visibility_id) REFERENCES Visibility(visibility_id)
);

CREATE INDEX idx_event_community ON Event(community_id);
CREATE INDEX idx_event_venue     ON Event(venue_id);
CREATE INDEX idx_event_starts    ON Event(starts_at);

-- Role catalog (reusable)
CREATE TABLE Role (
  role_id INTEGER PRIMARY KEY,
  name    TEXT NOT NULL UNIQUE,
  notes   TEXT
);

-- EventParticipation
CREATE TABLE EventParticipation (
  participation_id INTEGER PRIMARY KEY,
  person_name      TEXT NOT NULL,
  event_id         INTEGER NOT NULL,
  role_id          INTEGER NOT NULL,
  notes            TEXT,

  visibility_id    INTEGER NOT NULL,
  created_at       TEXT NOT NULL DEFAULT (datetime('now')),

  FOREIGN KEY (event_id)      REFERENCES Event(event_id) ON DELETE CASCADE,
  FOREIGN KEY (role_id)       REFERENCES Role(role_id),
  FOREIGN KEY (visibility_id) REFERENCES Visibility(visibility_id),

  UNIQUE(person_name, event_id, role_id)
);

CREATE INDEX idx_participation_event ON EventParticipation(event_id);
CREATE INDEX idx_participation_role  ON EventParticipation(role_id);

-- Contribution
CREATE TABLE Contribution (
  contribution_id INTEGER PRIMARY KEY,
  event_id        INTEGER NOT NULL,

  type            TEXT NOT NULL,
  title           TEXT NOT NULL,
  description     TEXT,

  starts_at       TEXT,
  ends_at         TEXT,

  visibility_id   INTEGER NOT NULL,
  created_at      TEXT NOT NULL DEFAULT (datetime('now')),

  CHECK (ends_at IS NULL OR starts_at IS NULL OR julianday(ends_at) >= julianday(starts_at)),

  FOREIGN KEY (event_id)      REFERENCES Event(event_id) ON DELETE CASCADE,
  FOREIGN KEY (visibility_id) REFERENCES Visibility(visibility_id)
);

CREATE INDEX idx_contribution_event ON Contribution(event_id);

-- Posts
CREATE TABLE Post (
  post_id       INTEGER PRIMARY KEY,
  platform      TEXT NOT NULL,
  url           TEXT NOT NULL UNIQUE,
  published_at  TEXT,
  title         TEXT,
  notes         TEXT,
  visibility_id INTEGER NOT NULL,
  created_at    TEXT NOT NULL DEFAULT (datetime('now')),

  FOREIGN KEY (visibility_id) REFERENCES Visibility(visibility_id)
);

-- Event ↔ Post link
CREATE TABLE EventPost (
  event_id INTEGER NOT NULL,
  post_id  INTEGER NOT NULL,
  PRIMARY KEY (event_id, post_id),

  FOREIGN KEY (event_id) REFERENCES Event(event_id) ON DELETE CASCADE,
  FOREIGN KEY (post_id)  REFERENCES Post(post_id)  ON DELETE CASCADE
);

-- Media assets
CREATE TABLE MediaAsset (
  asset_id      INTEGER PRIMARY KEY,
  asset_type    TEXT NOT NULL,
  taken_at      TEXT,
  storage_ref   TEXT,
  caption       TEXT,
  visibility_id INTEGER NOT NULL,
  created_at    TEXT NOT NULL DEFAULT (datetime('now')),

  FOREIGN KEY (visibility_id) REFERENCES Visibility(visibility_id)
);

-- Event ↔ Media link
CREATE TABLE EventMedia (
  event_id  INTEGER NOT NULL,
  asset_id  INTEGER NOT NULL,
  is_cover  INTEGER NOT NULL DEFAULT 0 CHECK(is_cover IN (0,1)),
  PRIMARY KEY (event_id, asset_id),

  FOREIGN KEY (event_id) REFERENCES Event(event_id)       ON DELETE CASCADE,
  FOREIGN KEY (asset_id) REFERENCES MediaAsset(asset_id)  ON DELETE CASCADE
);

-- =========================
-- REFLECTIONS & NLP SIGNALS
-- =========================

-- Reflection = a textual note anchored to something in PURE (optional)
-- source_type:
--   STUDY  -> StudySession.session_id
--   EVENT  -> Event.event_id
--   WORK   -> Engagement.engagement_id (work)
--   EDUCATION -> Engagement.engagement_id (education)
--   VOLUNTEERING -> Engagement.engagement_id (volunteering)
--   OTHER  -> no specific link
CREATE TABLE Reflection (
  reflection_id INTEGER PRIMARY KEY,
  source_type   TEXT NOT NULL, -- STUDY / EVENT / WORK / EDUCATION / VOLUNTEERING / OTHER
  source_id     INTEGER,       -- meaning depends on source_type
  created_at    TEXT NOT NULL,
  text          TEXT NOT NULL,

  visibility_id INTEGER NOT NULL,

  FOREIGN KEY (visibility_id) REFERENCES Visibility(visibility_id)
);

CREATE INDEX idx_reflection_source  ON Reflection(source_type, source_id);
CREATE INDEX idx_reflection_created ON Reflection(created_at);
CREATE INDEX idx_reflection_vis     ON Reflection(visibility_id);

-- ReflectionAnalysis = output of Azure AI Language (or similar) over a reflection
CREATE TABLE ReflectionAnalysis (
  analysis_id         INTEGER PRIMARY KEY,
  reflection_id       INTEGER NOT NULL,

  provider            TEXT NOT NULL, -- e.g. 'azure-ai-language'
  language_code       TEXT,          -- e.g. 'es'

  sentiment_label     TEXT,          -- positive / neutral / negative / mixed
  sentiment_positive  REAL,
  sentiment_neutral   REAL,
  sentiment_negative  REAL,

  key_phrases         TEXT,          -- comma-separated list for now
  category            TEXT,          -- high-level category (learning / community / career / ...)

  pii_flag            INTEGER NOT NULL DEFAULT 0 CHECK(pii_flag IN (0,1)),

  visibility_id       INTEGER NOT NULL,
  created_at          TEXT NOT NULL DEFAULT (datetime('now')),

  FOREIGN KEY (reflection_id) REFERENCES Reflection(reflection_id) ON DELETE CASCADE,
  FOREIGN KEY (visibility_id) REFERENCES Visibility(visibility_id)
);

CREATE INDEX idx_refanalysis_ref       ON ReflectionAnalysis(reflection_id);
CREATE INDEX idx_refanalysis_sentiment ON ReflectionAnalysis(sentiment_label);
CREATE INDEX idx_refanalysis_category  ON ReflectionAnalysis(category);
CREATE INDEX idx_refanalysis_vis       ON ReflectionAnalysis(visibility_id);

-- =========================
-- PORTFOLIO SEARCH BASE VIEW
-- =========================

-- v_portfolio_search_items:
-- Unified, PUBLIC-facing view of items that should appear in "search".
--
-- item_type:
--   TOPIC
--   EVENT
--   ENGAGEMENT
--   CONTRIBUTION
--   REFLECTION
--
-- item_key:
--   Corresponding primary key in the source table.
--
-- main_date:
--   Created_at / starts_at / started_on depending on source.
--
-- title / kind_label / secondary_label:
--   Textual fields for display and filtering.
--
-- location:
--   City when applicable.
--
-- tags_text:
--   Concatenated tags where applicable (topics).
--
-- sentiment_label, category:
--   From ReflectionAnalysis only (NULL for other item types).
CREATE VIEW v_portfolio_search_items AS
-- Studies: Topics
SELECT
  'TOPIC'                          AS item_type,
  t.topic_id                       AS item_key,
  t.created_at                     AS main_date,
  t.name                           AS title,
  'Study topic'                    AS kind_label,
  NULL                             AS secondary_label,
  NULL                             AS location,
  GROUP_CONCAT(DISTINCT tg.name)   AS tags_text,
  NULL                             AS sentiment_label,
  NULL                             AS category
FROM Topic t
LEFT JOIN TopicTag tt ON tt.topic_id = t.topic_id
LEFT JOIN Tag tg      ON tg.tag_id   = tt.tag_id
WHERE t.visibility_id = 1
GROUP BY t.topic_id

UNION ALL

-- Life: Events
SELECT
  'EVENT'                          AS item_type,
  e.event_id                       AS item_key,
  e.starts_at                      AS main_date,
  e.name                           AS title,
  'Event'                          AS kind_label,
  c.name                           AS secondary_label, -- community
  ci.name                          AS location,
  NULL                             AS tags_text,
  NULL                             AS sentiment_label,
  NULL                             AS category
FROM Event e
JOIN Community c ON e.community_id = c.community_id
JOIN Venue     v ON e.venue_id     = v.venue_id
JOIN City     ci ON v.city_id      = ci.city_id
WHERE e.visibility_id = 1

UNION ALL

-- Career & Roles: Engagements
SELECT
  'ENGAGEMENT'                     AS item_type,
  g.engagement_id                  AS item_key,
  g.started_on                     AS main_date,
  g.title                          AS title,
  et.name                          AS kind_label,       -- education / work / volunteering / project
  COALESCE(o.name, com.name)       AS secondary_label,  -- organization or community
  ci.name                          AS location,
  NULL                             AS tags_text,
  NULL                             AS sentiment_label,
  NULL                             AS category
FROM Engagement g
JOIN EngagementType et ON g.engagement_type_id = et.engagement_type_id
LEFT JOIN Organization o ON g.organization_id = o.organization_id
LEFT JOIN Community   com ON g.community_id   = com.community_id
LEFT JOIN City        ci  ON g.city_id        = ci.city_id
WHERE g.visibility_id = 1

UNION ALL

-- Life: Contributions (talks, panels, workshops...)
SELECT
  'CONTRIBUTION'                   AS item_type,
  c2.contribution_id               AS item_key,
  COALESCE(c2.starts_at, e2.starts_at) AS main_date,
  c2.title                         AS title,
  c2.type                          AS kind_label,       -- talk / panel / workshop / organizer
  e2.name                          AS secondary_label,  -- event name
  ci2.name                         AS location,
  NULL                             AS tags_text,
  NULL                             AS sentiment_label,
  NULL                             AS category
FROM Contribution c2
JOIN Event  e2 ON c2.event_id = e2.event_id
JOIN Venue v2  ON e2.venue_id = v2.venue_id
JOIN City  ci2 ON v2.city_id  = ci2.city_id
WHERE c2.visibility_id = 1

UNION ALL

-- Reflections: text + NLP signals
SELECT
  'REFLECTION'                     AS item_type,
  r.reflection_id                  AS item_key,
  r.created_at                     AS main_date,
  substr(r.text, 1, 80)            AS title,
  COALESCE(a.category, 'reflection') AS kind_label,
  a.sentiment_label                AS secondary_label,
  NULL                             AS location,
  NULL                             AS tags_text,
  a.sentiment_label                AS sentiment_label,
  a.category                       AS category
FROM Reflection r
LEFT JOIN ReflectionAnalysis a
  ON a.reflection_id = r.reflection_id
WHERE r.visibility_id = 1;

-- =========================
-- REFLECTION SIGNALS VIEW
-- =========================

-- v_reflection_signals:
-- Public reflections with their main NLP signals.
CREATE VIEW v_reflection_signals AS
SELECT
  r.reflection_id,
  r.source_type,
  r.source_id,
  r.created_at,
  LENGTH(r.text)                     AS char_length,
  r.text                             AS full_text,

  a.provider,
  a.language_code,
  a.sentiment_label,
  a.sentiment_positive,
  a.sentiment_neutral,
  a.sentiment_negative,
  a.key_phrases,
  a.category
FROM Reflection r
LEFT JOIN ReflectionAnalysis a
  ON a.reflection_id = r.reflection_id
WHERE r.visibility_id = 1;

-- =========================
-- CROSS-LAYER METRICS (Studies + Life)
-- =========================

-- One row per day where there is either study activity or events (or both).
-- Combines:
--   - StudySession (DONE sessions)
--   - Event (PUBLIC events)
CREATE VIEW v_calendar_day_activity AS
SELECT
  day                           AS calendar_day,
  SUM(study_minutes)            AS total_study_minutes,
  SUM(event_count)              AS total_events
FROM (
  -- Study contribution
  SELECT
    date(started_at)            AS day,
    SUM(duration_minutes)       AS study_minutes,
    0                           AS event_count
  FROM StudySession
  WHERE status_id = 1
  GROUP BY date(started_at)

  UNION ALL

  -- Event contribution
  SELECT
    date(starts_at)             AS day,
    0                           AS study_minutes,
    COUNT(*)                    AS event_count
  FROM Event
  WHERE visibility_id = 1
  GROUP BY date(starts_at)
)
GROUP BY day
ORDER BY day;

-- =========================
-- ML-READY VIEWS (no ML, only dataset shaping)
-- =========================

-- v_ml_study_sessions:
-- One row per DONE study session, enriched with:
--   - study_day
--   - day_of_week
--   - is_weekend
--   - total_events that day
--   - has_event flag
CREATE VIEW v_ml_study_sessions AS
SELECT
  s.session_id,
  s.topic_id,
  date(s.started_at)                            AS study_day,
  STRFTIME('%w', s.started_at)                  AS day_of_week,   -- 0=Sunday ... 6=Saturday
  CASE
    WHEN STRFTIME('%w', s.started_at) IN ('0','6') THEN 1
    ELSE 0
  END                                           AS is_weekend,
  s.duration_minutes,
  s.difficulty,
  s.energy,
  COALESCE(c.total_events, 0)                   AS events_that_day,
  CASE
    WHEN COALESCE(c.total_events, 0) > 0 THEN 1
    ELSE 0
  END                                           AS has_event
FROM StudySession s
LEFT JOIN v_calendar_day_activity c
  ON c.calendar_day = date(s.started_at)
WHERE s.status_id = 1;

-- =========================
-- DERIVED METRICS
-- =========================

-- Daily metrics for real study (DONE only)
CREATE VIEW v_day_metrics AS
SELECT
  date(started_at)                      AS study_day,
  SUM(duration_minutes)                 AS total_minutes,
  ROUND(AVG(difficulty), 2)             AS average_difficulty,
  ROUND(AVG(energy), 2)                 AS average_energy
FROM StudySession
WHERE status_id = 1
GROUP BY date(started_at);