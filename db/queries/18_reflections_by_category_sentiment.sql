SELECT
  a.category,
  a.sentiment_label,
  COUNT(*) AS count_reflections
FROM Reflection r
JOIN ReflectionAnalysis a
  ON a.reflection_id = r.reflection_id
WHERE r.visibility_id = 1
GROUP BY a.category, a.sentiment_label
ORDER BY a.category, a.sentiment_label;