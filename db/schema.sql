PRAGMA foreign_keys = ON;

-- =========================
-- DROP (safe rebuild)
-- =========================
DROP VIEW IF EXISTS v_day_metrics;

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