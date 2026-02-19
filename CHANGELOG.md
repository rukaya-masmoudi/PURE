# Changelog

All notable changes to PURE will be documented here.

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