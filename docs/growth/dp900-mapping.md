# DP-900 mapping — how PURE reflects the exam concepts

This document explains how the current version of PURE maps to key DP-900 concepts.

It is not a study guide.
It is an architectural traceability document.

---

## Data concepts and relational model

**DP-900 topics:**

- Core data concepts (tables, relationships, constraints)
- Relational data modeling
- Normalization and keys

**PURE implementation:**

- Tables:
  - Topics, study sessions, certifications, tags
  - Communities, venues, events, participations
- Relationships:
  - Foreign keys between core entities
  - Catalog-based modeling (Provider, Category, Role, Visibility, ...)
- Constraints:
  - CHECK constraints for ranges (difficulty, energy, scores)
  - Uniqueness constraints (names, codes)
  - Views for derived metrics (`v_day_metrics`, `v_calendar_day_activity`, `v_ml_study_sessions`)

---

## Analytical workloads

**DP-900 topics:**

- Basic analytical workloads
- Aggregations, grouping, time-based analysis

**PURE implementation:**

- Daily metrics:
  - `v_day_metrics`
  - `01_day_metrics.sql`
- Weekly and monthly views:
  - `02_week_metrics.sql`
  - `03_month_consistency.sql`
- Cross-layer calendar:
  - `v_calendar_day_activity`
  - `11_calendar_day_activity.sql`
  - `12_calendar_my_activity_detail.sql`

These pieces show how operational data can be transformed into analytical views.

---

## Non-relational considerations (intentionally out of scope for now)

DP-900 also covers:

- Non-relational data stores
- Key-value, document, column-family, and graph models

PURE intentionally stays on the relational side:

- SQLite as the only engine
- A single relational schema with clear constraints
- No emulation of NoSQL models yet

Non-relational choices will be considered later,
when the System and Intelligence blocks require them.

---

## Building datasets for machine learning

**DP-900 + “Create Machine Learning Models” topics:**

- Preparing tabular data for ML
- Using features such as dates, categories, and numeric values

**PURE implementation:**

- Raw study behaviour:
  - `StudySession` (duration_minutes, difficulty, energy, visibility, status)
- Cross-layer enrichment:
  - `v_calendar_day_activity` (events per day)
- ML-ready dataset:
  - `v_ml_study_sessions`
  - `13_ml_study_sessions_export.sql`

`v_ml_study_sessions` shows how operational events (study sessions + events)
can be converted into a tabular dataset:

- One row per session
- Enriched with:
  - day_of_week
  - is_weekend
  - events_that_day
  - has_event flag

This mirrors the “prepare your data” phase of the Create Machine Learning Models learning path,
without training any models inside PURE.

---

## Security and governance (light touch)

DP-900 touches on:

- Basic security and access control
- Data governance concepts

PURE reflects these ideas through:

- A visibility model (PUBLIC vs PRIVATE) on entities
- Separation of:
  - structural schema (`schema.sql`)
  - sample non-sensitive public seed (`seed.sql`)
- A reproducible build script (`tools/build_db.py`)

Full governance and security architectures are reserved for future phases,
once the foundations are stable.