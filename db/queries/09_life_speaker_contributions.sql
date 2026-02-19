SELECT
  date(e.starts_at)           AS event_date,
  e.name                      AS event_name,
  c.name                      AS community,
  contrib.type                AS contribution_type,
  contrib.title               AS contribution_title,
  contrib.description         AS contribution_description,
  contrib.starts_at,
  contrib.ends_at
FROM Contribution contrib
JOIN Event e      ON e.event_id      = contrib.event_id
JOIN Community c  ON c.community_id  = e.community_id
WHERE contrib.visibility_id = 1
ORDER BY e.starts_at DESC;