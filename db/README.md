# Database

This folder contains the SQLite definition of PURE.

Current scope:

- Studies Layer
- Life Layer (structural)

## Structure

- schema.sql  — tables, constraints, indexes, and derived views
- seed.sql    — minimal public seed data (real but non-sensitive)
- queries/    — curated SQL queries to explore growth metrics (Studies)
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

No analytics or cross-layer joins are implemented yet.

This keeps the schema structural and honest:
it describes where you show up and how you participate,
without storing unnecessary data about other people.