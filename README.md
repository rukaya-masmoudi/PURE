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

### Reflections & NLP signals

Run:

- db/queries/16_reflections_latest.sql  
- db/queries/17_reflections_search.sql  
- db/queries/18_reflections_by_category_sentiment.sql

For more details:

- docs/intelligence/overview.md
- docs/intelligence/ai-language-mapping.md
- docs/intelligence/azure-ai-language-ingestion.md

#### Labels

Run:

- db/queries/22_reflection_labels_overview.sql
- db/queries/23_reflections_by_label.sql
- db/queries/24_reflection_label_matrix.sql

#### Ingest Azure AI Language outputs (offline)

python tools/ingest_reflection_analysis.py path/to/analysis.jsonl

### Portfolio Search (base)

Run:

- db/queries/19_portfolio_all_items.sql  
- db/queries/20_portfolio_search_by_text.sql  
- db/queries/21_portfolio_filter_by_type.sql

For search index design details:

- docs/intelligence/azure-ai-search-index-design.md

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

### Reflections & NLP signals

- Signal Intelligence v1:
  - Reflections with Azure AI Language signals:
    - sentiment (label + scores)
    - key phrases
    - categories
    - PII flag
    - multi-label taxonomy
  - Unified portfolio search view:
    - v_portfolio_search_items
  - Offline ingestion pipeline for Azure AI Language outputs

PURE does not run Azure AI Language at build time.
It stores and exposes the resulting signals as structured data.

### Portfolio Search

- Knowledge mining (design-level):
  - Portfolio Search base view (`v_portfolio_search_items`)
  - Azure AI Search index design documented in:
    - `docs/intelligence/azure-ai-search-index-design.md`

### Generative Layer (Design)

PURE Assistant v0 is architecturally defined:

- Reads structured data from SQLite
- Uses Semantic Kernel as prompt orchestrator
- Uses Azure OpenAI for generation
- Fully governed and read-only

Design document:

- docs/intelligence/generative-layer-design.md

### PURE Assistant v0 (skeleton)

A first, local-only assistant is available under:

- `assistant/`

It:

- reads PUBLIC data from the SQLite database
- builds a JSON context from:
  - `v_portfolio_search_items`
  - `v_reflection_signals`
- uses Semantic Kernel + Azure OpenAI (via env vars) to generate answers
- is read-only and fully governed

For execution instructions, see:

- docs/intelligence/pure-assistant-usage.md