# PURE — Data-first professional system

PURE is my living portfolio.

It is not a showcase.
It is a structured, reproducible system that models my professional growth as data.

Before AI, there is data.

---

## Start here

1. Read the map:

   docs/map/overview.md

2. Understand Identity as data:

   docs/identity/identity-as-data.md

3. Then build the database:

```bash
python tools/build_db.py
```

This creates:

   db/pure.db

---

## Explore insights

Open `db/pure.db` in any SQLite client.

### Studies

Run:

db/queries/01_day_metrics.sql  
db/queries/02_week_metrics.sql  
db/queries/03_month_consistency.sql  
db/queries/04_top_topics.sql  
db/queries/05_energy_vs_difficulty.sql  
db/queries/06_tags_focus.sql  

### Life

Run:

db/queries/07_life_events_timeline.sql  
db/queries/08_life_my_participation.sql  
db/queries/09_life_speaker_contributions.sql  
db/queries/10_life_events_with_covers.sql 

### Calendar (Studies + Life)

Run:

db/queries/11_calendar_day_activity.sql  
db/queries/12_calendar_my_activity_detail.sql

### Career & Roles

Run:

- db/queries/14_career_timeline.sql  
- db/queries/15_career_active_engagements.sql

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

### Cross-layer calendar

- View v_calendar_day_activity combines Studies and Life by date.
- Queries 11–12 expose calendar-based views of your activity.

No AI.
No dashboards.
No frontend.

Those will come later, phase by phase, on top of this foundation.

### Career & Roles Layer

- Organizations (companies and educational centers)
- Communities
- Engagement types (education, work, volunteering, project)
- Engagements describing my long-running roles and experiences
- Query pack in db/queries/ (14–15)