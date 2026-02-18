SELECT
  t.name AS topic,
  ROUND(SUM(s.duration_minutes) / 60.0, 2) AS total_hours,
  COUNT(*) AS sessions
FROM StudySession s
JOIN Topic t ON t.topic_id = s.topic_id
WHERE s.status_id = 1
GROUP BY t.topic_id
ORDER BY total_hours DESC;