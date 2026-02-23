-- Simple text search over unified portfolio items.
-- Replace :query with your search term in your SQLite client.
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
WHERE
  title           LIKE '%' || :query || '%'
  OR COALESCE(secondary_label, '') LIKE '%' || :query || '%'
  OR COALESCE(tags_text, '')       LIKE '%' || :query || '%'
ORDER BY main_date DESC, item_type, item_key;