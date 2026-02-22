# Database

This folder contains the SQLite definition of PURE.

Current scope:

- Studies Layer
- Life Layer (structural)
- Cross-layer calendar views
- Career & Roles Layer

## Structure

- schema.sql  — tables, constraints, indexes, and derived views
- seed.sql    — minimal public seed data (real but non-sensitive)
- queries/    — curated SQL queries to explore growth metrics (Studies, Life, Calendar, Career)
- pure.db     — generated locally (ignored by git)

---

## Rebuild locally

From the repository root:

```bash
python tools/build_db.py
```

This recreates the database from scratch using `schema.sql` and `seed.sql`.

---

## Studies Layer

The Studies Layer models:

- Topics (learning units)
- Study sessions (when and how you study)
- Practice results and certification structure
- Tags (technologies, ML techniques, etc.)
- Derived daily metrics (view `v_day_metrics`)

Use the queries in `db/queries/` to explore:

- 01_day_metrics.sql — daily minutes
- 02_week_metrics.sql — weekly hours
- 03_month_consistency.sql — active days per month
- 04_top_topics.sql — focus by topic
- 05_energy_vs_difficulty.sql — cognitive load
- 06_tags_focus.sql — tag-based focus

---

## Life Layer

The Life Layer models your professional activity:

- Community, City, Venue
- Events with external URLs and language
- Your participation roles (attendee, speaker, community-collaborator)
- Contributions when you actively speak (Contribution)
- Media assets as metadata only (cover photos per event)

Life exploration is supported by:

- 07_life_events_timeline.sql — events, communities, venues, cities
- 08_life_my_participation.sql — where you participated and how
- 09_life_speaker_contributions.sql — events where you speak
- 10_life_events_with_covers.sql — events with their cover images

---

## Cross-layer calendar

The calendar views combine Studies and Life by date:

- View v_calendar_day_activity — one row per day, with:
  - total_study_minutes
  - total_events

Queries:

- 11_calendar_day_activity.sql — direct access to v_calendar_day_activity
- 12_calendar_my_activity_detail.sql — same data with a human-readable label:
  - study only
  - events only
  - study + events

No additional analytics or joins beyond the calendar are implemented yet.

This keeps the model simple and focused on a single question:
on which days am I learning, showing up in the community, or both?

### ML-ready view

The view `v_ml_study_sessions` provides an ML-ready dataset:

- One row per DONE study session
- Features:
  - study_day, day_of_week, is_weekend
  - duration_minutes, difficulty, energy
  - events_that_day, has_event

Use:

- `13_ml_study_sessions_export.sql` to export this dataset for external ML experiments.

---

## Career & Roles Layer

The Career & Roles Layer models long-running relationships with organizations and communities:

- Organization:
  - Companies
  - Educational centers
- Community:
  - Tech communities
- EngagementType:
  - education
  - work
  - volunteering
  - project (reserved for later)
- Engagement:
  - One row per long-running relationship:
    - education programs
    - jobs
    - volunteering roles

Queries:

- 14_career_timeline.sql - Full timeline of my education, work and volunteering, ordered by date.

- 15_career_active_engagements.sql - Current active engagements, showing what I am doing now.

This layer connects who I am (Identity) with where I work and contribute (System, Impact),
using the same data-first, queryable approach as the rest of PURE.