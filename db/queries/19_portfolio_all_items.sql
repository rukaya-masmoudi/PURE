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
ORDER BY main_date DESC, item_type, item_key;