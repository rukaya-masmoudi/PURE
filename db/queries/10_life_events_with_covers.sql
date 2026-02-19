SELECT
  e.event_id,
  date(e.starts_at)           AS event_date,
  e.name                      AS event_name,
  c.name                      AS community,
  v.name                      AS venue,
  ci.name                     AS city,
  m.storage_ref               AS cover_path,
  m.caption                   AS cover_caption
FROM Event e
JOIN Community c   ON c.community_id = e.community_id
JOIN Venue v       ON v.venue_id     = e.venue_id
JOIN City ci       ON ci.city_id     = v.city_id
JOIN EventMedia em ON em.event_id    = e.event_id
JOIN MediaAsset m  ON m.asset_id     = em.asset_id
WHERE e.visibility_id = 1
  AND em.is_cover = 1
ORDER BY e.starts_at DESC;