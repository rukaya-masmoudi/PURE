# PURE — Data-first professional system

PURE is my living portfolio.

It is not a showcase.
It is a structured, reproducible system that models my professional growth as data.

Before AI, there is data.

---

## Start here

Read:

docs/start-here/how-to-navigate.md

---

## Build the database (local)

From the repository root:

```bash
python tools/build_db.py
```
This creates:

`db/pure.db`

---

## Explore insights

Open `db/pure.db` in any SQLite client.

### Studies

Run the queries inside:

db/queries/01_day_metrics.sql  
db/queries/02_week_metrics.sql  
db/queries/03_month_consistency.sql  
db/queries/04_top_topics.sql  
db/queries/05_energy_vs_difficulty.sql  
db/queries/06_tags_focus.sql  

### Life

Run the queries:

db/queries/07_life_events_timeline.sql  
db/queries/08_life_my_participation.sql  
db/queries/09_life_speaker_contributions.sql  
db/queries/10_life_events_with_covers.sql 

---

## Current scope

### Studies Layer

- Catalogs for providers, categories, learning levels, and certification tiers
- Topics and study sessions with visibility and status
- Practice results and certification structure
- Tags for topics and sessions
- Derived daily metrics (view `v_day_metrics`)
- Query pack in `db/queries/` (01-06)

### Life Layer (structural)

- Communities
- Cities and venues
- Events with external URLs and language
- My participation roles (attendee, speaker, community-collaborator)
- Contributions when I actively speak
- One cover image per event (metadata only, files in `docs/assets/events/`)
- Query pack in db/queries/ (07–10)

No AI.
No dashboards.
No frontend.

That will come later, phase by phase.