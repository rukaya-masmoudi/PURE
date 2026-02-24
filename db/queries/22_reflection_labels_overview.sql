SELECT
  l.label_id,
  l.name,
  l.description,
  COUNT(rla.reflection_id) AS reflections_count
FROM ReflectionLabel l
LEFT JOIN ReflectionLabelAssignment rla
  ON rla.label_id = l.label_id
LEFT JOIN Reflection r
  ON r.reflection_id = rla.reflection_id
  AND r.visibility_id = 1
GROUP BY l.label_id, l.name, l.description
ORDER BY reflections_count DESC, l.label_id;