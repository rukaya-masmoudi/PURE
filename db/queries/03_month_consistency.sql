SELECT
  strftime('%Y-%m', started_at) AS year_month,
  COUNT(DISTINCT date(started_at)) AS active_days,
  COUNT(*) AS sessions,
  ROUND(SUM(duration_minutes) / 60.0, 2) AS total_hours
FROM StudySession
WHERE status_id = 1
GROUP BY year_month
ORDER BY year_month;