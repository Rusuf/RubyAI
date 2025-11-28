# Using the Existing DB for AI: What’s Useful and How to Start

This guide explains how the current MySQL schema can power the Rust AI backend and how to pull data safely and incrementally.

## Why this DB is useful for AI
- Rich transactional history: `sales`, `receipts`, and `orders` capture item-level demand, channels, timing.
- Product catalog: `products` contains pricing, categories, stock signals (`current_stock`, `restock_level`).
- Purchasing and costs: `purchased_order`, `invoices`, `ingredients` tables allow cost of goods and margin analysis.
- Customer signals: `customers` for loyalty and repeat behavior (IDs/names vary; expect cleanup).
- Operational context: `shift_*`, `cash_at_hand`, `mpesa` help correlate ops with demand anomalies.
- Built-in change log: triggers populate `log_table_sync_change` enabling reliable incremental sync.

## Core AI Use-Cases Supported
- Recommendations (also-bought/content-based): from `sales` co-occurrence and `products` attributes.
- Stock optimization and forecasting: from `sales` time series + `products` stock/restock and purchase data.
- Anomaly detection: sales vs shift/receipt/payment mismatches.

## Data model to extract
- Product(id, code, name, category, prices, unit, stock)
- Sale(id, timestamp, receipt_no, product_code, qty, net/gross, customer)
- Receipt(id, receipt_no, timestamp, payment_channel, customer)
- Customer(id or normalized key, name, contact)
- Purchase(invoice, product_code, qty, cost, date)

## Getting Data Out (Initial SQL)
- Latest sales
```sql
SELECT sale_id, thedate, receipt_no, product_code, productname, quantity, sellingprice, totalsales, customer
FROM sales
WHERE thedate >= NOW() - INTERVAL 30 DAY
ORDER BY thedate DESC;
```
- Product catalog snapshot
```sql
SELECT product_id, product_code, productname, category, department, unit, buyingprice, sellingprice, current_stock
FROM products
WHERE inventory_status = 'Active';
```
- Receipt join (implicit by receipt_no)
```sql
SELECT r.receipt_no, r.date, r.payment_channel, s.product_code, s.quantity, s.totalsales
FROM receipts r
JOIN sales s ON s.receipt_no = r.receipt_no
WHERE r.date >= NOW() - INTERVAL 30 DAY;
```

## Incremental Ingest with Change Log
- Source: `log_table_sync_change(change_type, table_name, primary_key_value, change_time, status)`
- Strategy:
  1. Maintain a high-watermark `last_seen_change_time` in Rust.
  2. Pull changes newer than the watermark in batches.
  3. For each row, re-fetch the full record from its source table by primary key.
  4. Upsert/delete into your Rust-owned store (Postgres recommended).

Example poll query:
```sql
SELECT id, table_name, primary_key_column, primary_key_value, change_type, change_time
FROM log_table_sync_change
WHERE change_time > ?
  AND status = 'pending'
ORDER BY change_time ASC
LIMIT 1000;
```
Then fetch the record (example for `sales`):
```sql
SELECT * FROM sales WHERE sale_id = ?;
```

## Rust Ingest Skeleton (pseudocode)
```rust
loop {
  let changes = fetch_changes_after(watermark)?;
  for ch in changes {
    match ch.table_name.as_str() {
      "sales" => upsert_sale(fetch_sale(ch.pk)?)?,
      "products" => upsert_product(fetch_product(ch.pk)?)?,
      // ... handle others
      _ => {}
    }
    watermark = ch.change_time;
  }
  sleep(poll_interval);
}
```

## Data Quality Notes
- Few foreign keys: join by `receipt_no`, `product_code`, names; normalize into IDs in Rust.
- Mixed engines (MyISAM/InnoDB): avoid cross-transaction assumptions.
- Numeric fields stored as strings in some tables: cast carefully.

## Next Steps
- Stand up a Rust Postgres store for clean, analytics-ready models.
- Implement a minimal extractor (reqwest+mysql or ODBC) and an upserter.
- Start with `products`, `sales`, `receipts`; expand to purchases and customers.
