SELECT
  l.name           AS label_name,
  a.sentiment_label,
  COUNT(*)         AS reflections_count
FROM ReflectionLabel l
JOIN ReflectionLabelAssignment rla
  ON rla.label_id = l.label_id
JOIN Reflection r
  ON r.reflection_id = rla.reflection_id
JOIN ReflectionAnalysis a
  ON a.reflection_id = r.reflection_id
WHERE r.visibility_id = 1
GROUP BY l.name, a.sentiment_label
ORDER BY l.name, a.sentiment_label;