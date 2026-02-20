SELECT
  calendar_day,
  total_study_minutes,
  total_events
FROM v_calendar_day_activity
ORDER BY calendar_day DESC;