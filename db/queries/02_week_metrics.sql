SELECT
  strftime('%Y-%W', started_at) AS year_week,
  ROUND(SUM(duration_minutes) / 60.0, 2) AS total_hours,
  COUNT(*) AS sessions
FROM StudySession
WHERE status_id = 1
GROUP BY year_week
ORDER BY year_week;