# How to navigate PURE (2 minutes)

PURE is not a portfolio repository.

It is a reproducible system that models my professional growth as structured data.

Before AI.
Before dashboards.
Before assistants.

There is data.

---

## What exists today

- Studies Layer (SQLite)
  - Topics, study sessions, tags, certifications
  - Public vs private visibility model
  - Derived daily metrics

- Life Layer (structural)
  - Communities, cities, venues
  - Events with date, location, and language
  - My roles in each event (attendee, speaker, community-collaborator)
  - One cover photo per event (metadata only)

This is the foundation.

---

## What you can explore

You can explore:

- How consistent I am when studying
- How many hours I invest per week
- Which topics I focus on
- Where I show up in the community
- In which events I participate and in which roles

All of this is queryable.
Nothing is decorative.

---

## How to explore Studies

1. Build the database:

```bash
python tools/build_db.py
```

2. Open db/pure.db in your SQLite client.

3. For Studies, run the queries in:

db/queries/01_day_metrics.sql  
db/queries/02_week_metrics.sql  
db/queries/03_month_consistency.sql  
db/queries/04_top_topics.sql  
db/queries/05_energy_vs_difficulty.sql  
db/queries/06_tags_focus.sql  

---

## How to explore Life

With the same database (db/pure.db), you can also explore:

db/queries/07_life_events_timeline.sql  
db/queries/08_life_my_participation.sql  
db/queries/09_life_speaker_contributions.sql  
db/queries/10_life_events_with_covers.sql  

---

## What is intentionally NOT here yet

- AI agents
- RAG
- Search assistants
- APIs
- Dashboards
- Cross-layer analytics (Studies ↔ Life)

PURE grows phase by phase.

---

PURE demonstrates that learning is not collecting certifications.

It is converting growth into a governed system.