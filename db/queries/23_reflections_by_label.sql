-- List reflections for a given label.
-- Replace :label_name with the label you want to inspect
-- e.g. 'machine-learning', etc.
SELECT
  r.reflection_id,
  r.created_at,
  r.source_type,
  r.source_id,
  substr(r.text, 1, 200) AS preview,
  a.sentiment_label,
  a.category
FROM ReflectionLabel l
JOIN ReflectionLabelAssignment rla
  ON rla.label_id = l.label_id
JOIN Reflection r
  ON r.reflection_id = rla.reflection_id
LEFT JOIN ReflectionAnalysis a
  ON a.reflection_id = r.reflection_id
WHERE l.name = :label_name
  AND r.visibility_id = 1
ORDER BY r.created_at DESC, r.reflection_id;