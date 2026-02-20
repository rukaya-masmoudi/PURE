-- For each day with activity, show:
--   - total study minutes
--   - number of events
--   - a simple “label” describing the day

WITH day_summary AS (
  SELECT
    c.calendar_day,
    c.total_study_minutes,
    c.total_events
  FROM v_calendar_day_activity c
),
labeled AS (
  SELECT
    calendar_day,
    total_study_minutes,
    total_events,
    CASE
      WHEN total_study_minutes > 0 AND total_events > 0 THEN 'study + events'
      WHEN total_study_minutes > 0 AND total_events = 0 THEN 'study only'
      WHEN total_study_minutes = 0 AND total_events > 0 THEN 'events only'
      ELSE 'no activity'
    END AS activity_type
  FROM day_summary
)
SELECT
  calendar_day,
  total_study_minutes,
  total_events,
  activity_type
FROM labeled
ORDER BY calendar_day DESC;