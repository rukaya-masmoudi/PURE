SELECT
  ROUND(AVG(difficulty), 2) AS avg_difficulty,
  ROUND(AVG(energy), 2) AS avg_energy,
  COUNT(*) AS sessions
FROM StudySession
WHERE status_id = 1;