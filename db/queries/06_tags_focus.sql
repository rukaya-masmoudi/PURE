SELECT
  tg.name AS tag,
  ROUND(SUM(s.duration_minutes) / 60.0, 2) AS total_hours,
  COUNT(*) AS sessions
FROM StudySession s
JOIN Topic t ON t.topic_id = s.topic_id
JOIN TopicTag tt ON tt.topic_id = t.topic_id
JOIN Tag tg ON tg.tag_id = tt.tag_id
WHERE s.status_id = 1
GROUP BY tg.tag_id
ORDER BY total_hours DESC;