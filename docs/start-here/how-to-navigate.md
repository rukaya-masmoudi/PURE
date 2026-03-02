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

- Cross-layer calendar
  - Days with study activity
  - Days with events
  - Days where both happen

- Career & Roles Layer
  - Organizations (companies and educational centers)
  - Long-running engagements:
    - education
    - work
    - volunteering
    - (projects reserved for later)

- ML-ready view (no ML inside PURE)
  - One row per study session
  - Enriched with calendar context (events that day)
- Reflections & NLP signals
  - Textual reflections anchored to studies, events or career
  - Sentiment, key phrases and high-level categories (output of Azure AI Language, stored as data)

This is the foundation.

---

## What you can explore

You can explore:

- How consistent I am when studying
- How many hours I invest per week
- Which topics I focus on
- Where I show up in the community
- In which events I participate and in which roles
- On which days learning and community activity overlap
- How a study session dataset can be prepared for ML experiments
- How my education, work and volunteering form a single career timeline

All of this is queryable.
Nothing is decorative.

---

## How to explore Studies

1. Build the database:

```bash
python tools/build_db.py
```

2. Open `db/pure.db` in your SQLite client.

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

## How to explore the calendar (Studies + Life)

Use:

db/queries/11_calendar_day_activity.sql
db/queries/12_calendar_my_activity_detail.sql

---

## How to explore the ML-ready dataset

If you want a tabular dataset of study sessions ready for external ML experiments:

- View:
  - v_ml_study_sessions

- Query:

  db/queries/13_ml_study_sessions_export.sql  

This does not train any model inside PURE.
It only prepares the data in a clean, reproducible way.

---

## How to explore Career & Roles

Use:

db/queries/14_career_timeline.sql  
db/queries/15_career_active_engagements.sql  

---

## How to explore Reflections & NLP signals

Use:

db/queries/16_reflections_latest.sql
db/queries/17_reflections_search.sql
db/queries/18_reflections_by_category_sentiment.sql
db/queries/22_reflection_labels_overview.sql  
db/queries/23_reflections_by_label.sql  
db/queries/24_reflection_label_matrix.sql  

---

## How to explore Portfolio Search (base layer)

The view:

- v_portfolio_search_items

provides a unified way to see:

- Study topics
- Events
- Career engagements
- Event contributions (talks, panels, workshops)
- Reflections with NLP signals

Use:

db/queries/19_portfolio_all_items.sql
db/queries/20_portfolio_search_by_text.sql
db/queries/21_portfolio_filter_by_type.sql

---

## Next: Search over PURE

The unified view:

- v_portfolio_search_items

is also the logical source for a future Azure AI Search index.

The index design is documented in:

- docs/intelligence/azure-ai-search-index-design.md

At this stage PURE only defines:

- what should be searchable
- how fields are structured

Actual Azure resources will be introduced in later phases.

---

## What is intentionally NOT here yet

- AI agents
- RAG
- Search assistants
- APIs
- Dashboards
- Rich cross-layer analytics (beyond calendar and the ML-ready view)

PURE grows phase by phase.

---

PURE demonstrates that learning is not collecting certifications.

It is converting growth into a governed system.