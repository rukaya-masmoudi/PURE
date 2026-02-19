SELECT
  date(e.starts_at)           AS event_date,
  e.name                      AS event_name,
  c.name                      AS community,
  r.name                      AS role,
  ep.notes                    AS participation_notes,
  v.name                      AS venue,
  ci.name                     AS city
FROM EventParticipation ep
JOIN Event e   ON e.event_id   = ep.event_id
JOIN Community c ON c.community_id = e.community_id
JOIN Venue v  ON v.venue_id    = e.venue_id
JOIN City ci  ON ci.city_id    = v.city_id
JOIN Role r   ON r.role_id     = ep.role_id
WHERE ep.person_name = 'Rukaya Masmoudi Messaoud'
  AND ep.visibility_id = 1
ORDER BY e.starts_at DESC;