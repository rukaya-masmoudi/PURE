-- Filter portfolio items by type.
-- Replace :item_type with one of:
--   TOPIC / EVENT / ENGAGEMENT / CONTRIBUTION / REFLECTION
SELECT
  item_type,
  item_key,
  main_date,
  title,
  kind_label,
  secondary_label,
  location,
  tags_text,
  sentiment_label,
  category
FROM v_portfolio_search_items
WHERE item_type = :item_type
ORDER BY main_date DESC, item_key;