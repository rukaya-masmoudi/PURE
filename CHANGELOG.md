# Changelog

All notable changes to PURE will be documented here.

## [0.1.0] - 2026-02-17
### Added
- SQLite "Studies Layer" schema (catalogs, topics, sessions, certifications)
- Minimal seed data (DP-900 + Create ML Models)
- Local build script to generate pure.db
- Derived view v_day_metrics for daily study metrics
- Guardrail constraint to enforce ended_at >= started_at in StudySession
- Extra indexes to support filtering by status, learning level, and tags

### Changed
- v_day_metrics now includes DONE sessions only
- build_db.py now generates db/pure.db and sets foreign_keys per connection

### Fixed
- README code fences for build command