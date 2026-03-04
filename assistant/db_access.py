from __future__ import annotations

import sqlite3
from pathlib import Path
from typing import Any, Dict, List


ROOT = Path(__file__).resolve().parents[1]
DB_PATH = ROOT / "db" / "pure.db"


def _get_connection() -> sqlite3.Connection:
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON;")
    return conn


def get_portfolio_items(limit: Optional[int] = None) -> List[Dict[str, Any]]:
    """
    Returns latest public items from v_portfolio_search_items.

    Used as generic context about:
    - studies
    - events
    - engagements
    - contributions
    - reflections
    """
    base_query = """
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
    ORDER BY main_date DESC, item_type, item_key
    """
    conn = _get_connection()
    try:
        if limit is None:
            rows = conn.execute(base_query).fetchall()
        else:
            query = base_query + " LIMIT ?"
            rows = conn.execute(query, (limit,)).fetchall()
        return [dict(row) for row in rows]
    finally:
        conn.close()


def get_reflection_signals(limit: OPTIONAL[int] = None) -> List[Dict[str, Any]]:
    """
    Returns latest public reflections with their NLP signals.

    Based on v_reflection_signals.
    """
    base_query = """
    SELECT
      reflection_id,
      created_at,
      source_type,
      source_id,
      char_length,
      full_text,
      provider,
      language_code,
      sentiment_label,
      sentiment_positive,
      sentiment_neutral,
      sentiment_negative,
      key_phrases,
      category,
      labels_text
    FROM v_reflection_signals
    ORDER BY datetime(created_at) DESC, reflection_id DESC
    """
    conn = _get_connection()
    try:
        if limit is None:
            rows = conn.execute(base_query).fetchall()
        else:
            query = base_query + " LIMIT ? "
            rows = conn.execute(query, (limit,)).fetchall()
        return [dict(row) for row in rows]
    finally:
        conn.close()