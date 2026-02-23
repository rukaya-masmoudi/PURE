SELECT
  r.reflection_id,
  r.created_at,
  r.source_type,
  r.source_id,
  substr(r.text, 1, 200) AS preview,
  a.sentiment_label,
  a.category
FROM Reflection r
LEFT JOIN ReflectionAnalysis a
  ON a.reflection_id = r.reflection_id
WHERE r.visibility_id = 1
ORDER BY r.created_at DESC, r.reflection_id DESC
LIMIT 50;