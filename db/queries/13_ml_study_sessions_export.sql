SELECT
  session_id,
  topic_id,
  study_day,
  day_of_week,
  is_weekend,
  duration_minutes,
  difficulty,
  energy,
  events_that_day,
  has_event
FROM v_ml_study_sessions
ORDER BY study_day DESC, session_id;