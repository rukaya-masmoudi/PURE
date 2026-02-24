# Changelog

All notable changes to PURE will be documented here.

## [0.1.7] - 2026-02-24
### Added
- Multi-label classification for reflections:
  - `ReflectionLabel` catalog
  - `ReflectionLabelAssignment` link table (N-to-N)
- Extended view:
  - `v_reflection_signals` now includes a `labels_text` field with all labels assigned to each reflection
- Reflection label query pack:
  - `22_reflection_labels_overview.sql`
  - `23_reflections_by_label.sql`
  - `24_reflection_label_matrix.sql`
- Azure AI Language ingestion contract:
  - `docs/intelligence/azure-ai-language-ingestion.md` describing the JSONL data contract
- Offline ingestion tool:
  - `tools/ingest_reflection_analysis.py` to ingest Azure AI Language outputs into:
    - `ReflectionAnalysis`
    - `ReflectionLabel` and `ReflectionLabelAssignment`
- Intelligence documentation for Signal Intelligence v1:
  - `docs/intelligence/overview.md`
  - `docs/intelligence/ai-language-mapping.md`
- Map and Identity updates:
  - Intelligence block in `docs/map/overview.md` now explicitly describes Signal Intelligence v1
  - Identity doc updated to include Reflections & NLP signals as part of Identity-as-data
- Documentation updates for:
  - Reflections & NLP navigation in `docs/start-here/how-to-navigate.md`
  - Root `README` updated with Signal Intelligence v1 scope and links to Intelligence docs
  - `db/README` updated to point to Intelligence documentation for Reflections & NLP

## [0.1.6] - 2026-02-23
### Added
- Reflections & NLP signals layer:
  - `Reflection` table to store textual reflections linked to studies, events or career engagements
  - `ReflectionAnalysis` table to store Azure AI Language outputs (sentiment, key phrases, categories)
  - View `v_reflection_signals` for public reflections and their main NLP signals
- NLP signal query pack:
  - `16_reflections_latest.sql`
  - `17_reflections_search.sql`
  - `18_reflections_by_category_sentiment.sql`
- Unified portfolio search view:
  - `v_portfolio_search_items` combining:
    - Study topics
    - Events
    - Career engagements
    - Event contributions
    - Reflections with NLP signals
- Portfolio search query pack:
  - `19_portfolio_all_items.sql`
  - `20_portfolio_search_by_text.sql`
  - `21_portfolio_filter_by_type.sql`
- Documentation updates for:
  - Start Here navigation (Reflections & NLP and Portfolio Search base)
  - `db/README` and `README` to include the Reflections & NLP layer and to reference the unified search view

## [0.1.5] - 2026-02-22
### Added
- ML-ready view `v_ml_study_sessions` to represent study sessions as a tabular dataset
- Query `13_ml_study_sessions_export.sql` for exporting the ML-ready dataset
- DP-900 mapping document:
  - docs/growth/dp900-mapping.md
- Documentation updates to:
  - Reference the ML-ready view and export query
- Career & Roles Layer:
  - Organization table for companies and educational centers
  - EngagementType catalog (education, work, volunteering, project)
  - Engagement table to represent long-running relationships with organizations or communities
- Seed data.
- Career query pack:
  - 14_career_timeline.sql
  - 15_career_active_engagements.sql
- Documentation updates for:
  - Start Here
  - db/README
  - Identity and Map docs

## [0.1.4] - 2026-02-20
### Added
- Cross-layer calendar view v_calendar_day_activity combining Studies and Life by date
- Calendar query pack:
  - 11_calendar_day_activity.sql
  - 12_calendar_my_activity_detail.sql
- Documentation updates for calendar exploration in:
  - README
  - db/README
  - docs/start-here/how-to-navigate.md
- PURE Map v1:
  - docs/map/overview.md
- Identity as data narrative:
  - docs/identity/identity-as-data.md
- README updates to:
  - Route users through the map
  - Clarify Identity, Growth, Impact, Calendar, and System scopes

## [0.1.3] - 2026-02-19
### Added
- Life Layer structural schema (Community, City, Venue, Event)
- Participation model (Role + EventParticipation)
- Contribution entity for events where I actively speak
- Media metadata model (MediaAsset + EventMedia) with one cover photo per event
- Life Layer query pack for Impact exploration:
  - `07_life_events_timeline.sql`
  - `08_life_my_participation.sql`
  - `09_life_speaker_contributions.sql`
  - `10_life_events_with_covers.sql`
- Documentation updates for Life exploration in:
  - README
  - db/README
  - docs/start-here/how-to-navigate.md

### Changed
- Documentation updated to reflect Life Layer in README, db/README, and Start Here

## [0.1.2] - 2026-02-18
### Added
- Start Here documentation (docs/start-here)
- Query pack for Growth exploration (db/queries)
- Improved README navigation structure

## [0.1.1] - 2026-02-17
### Added
- SQLite "Studies Layer" schema (catalogs, topics, sessions, certifications)
- Minimal seed data
- Local build script to generate `db/pure.db` and sets foreign_keys per connection
- Derived view `v_day_metrics` for daily study metrics includes DONE sessions only
- Guardrail constraint to enforce ended_at >= started_at in StudySession
- Extra indexes to support filtering by status, learning level, and tags
- README code fences for build command