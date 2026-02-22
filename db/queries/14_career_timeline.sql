SELECT
  e.engagement_id,
  et.name                             AS engagement_type,
  COALESCE(o.name, c.name)            AS entity_name,
  e.title,
  e.started_on,
  e.ended_on,
  e.is_current,
  ci.name                             AS city,
  e.description
FROM Engagement e
JOIN EngagementType et ON et.engagement_type_id = e.engagement_type_id
LEFT JOIN Organization o ON o.organization_id   = e.organization_id
LEFT JOIN Community c    ON c.community_id      = e.community_id
LEFT JOIN City ci        ON ci.city_id          = e.city_id
WHERE e.visibility_id = 1
ORDER BY e.started_on ASC, e.engagement_id;