# Database Schema (essayhar_ruby)

This summarizes key tables and relationships inferred from `ruby.sql` (MariaDB/MySQL).

## Conventions
- Most tables include sync fields: `sync_uuid`, `last_updated`, `sync_status`, `sync_last_updated`
- Triggers write row-change events into `log_table_sync_change`
- Engines vary (InnoDB/MyISAM); some lack explicit foreign keys

## Change Log
- `log_table_sync_change(id, table_name, row_id, primary_key_column, primary_key_value, change_type, change_time, status, synced_at)`
- Populated by AFTER INSERT/UPDATE/DELETE triggers across many tables

## Core Commerce
- `products(product_id, product_code, productname, department, category, unit, buyingprice, sellingprice, current_stock, restock_level, restock_quantity, ... )`
- `sales(sale_id, receipt_no, product_code, productname, quantity, sellingprice, totalsales, cost_of_goods_sold, profit, customer, sales_rep, chef, cashier, payment_channel, payment_ref, ...)`
- `receipts(receipt_id, receipt_no, totals, tendered, change_amount, payment_channel, payment_ref, customer, sales_rep, chef, cashier, status, ...)`
- `orders(id, product_id, product_name, product_price, product_qty, ...)` — simple order items table
- `customers(customer_id, name, phone_number, email, loyalty_points, status, ...)`

Likely relationships (implicit):
- `sales.receipt_no` → `receipts.receipt_no`
- `sales.product_code` → `products.product_code`
- `orders.product_id` → `products.product_id`
- `receipts.customer` → `customers.name` (name, not id)

## Inventory and Purchasing
- `purchased_order(product_id, invoice_no, product_code, quantity, unit, buyingprice, sellingprice, current_stock, ... )`
- `invoices(invoice_id, invoice_no, supplier, totals..., received_by, last_edited_on, ...)`
- `purchased_ingredients / purchased_essential_supplies` — per-item purchase lines
- `ingredients / essential_supplies` — inventory catalogs similar to `products`
- `ingredients_invoices / essential_supplies_invoices / expired_products_invoices / damaged_products_invoices` — supplier invoices by category
- `products_categories / products_departments / products_parent_categories / products_units` — catalogs
- `restock_level(id, last_restock_level, date_modified)` — global config

## Quality and Adjustments
- `expired_products`, `damaged_products` — write-offs
- `sales_errors`, `samz_taste_sales_errors` — stock error logs

## Financial and Ops
- `cash_at_hand`, `mpesa`, `pettycash`, `opening_balance` — cash management
- `sales_reconciliation`, `shift_reconciliation`, `shift_management`, `shift_manager` — daily/shift reconciliation
- `expenses`, `expense_categories` — expense tracking
- `credit` — credit sales and balances
- `store_config` — store metadata and receipt settings
- `password_reset_temp` — temp auth
- `dispatched_order_delete_log`, `dispatch_log` — stock dispatch events

## Trends/Derived
- `sales_analysis(productname, quantity, totalsales, profit)` — aggregated
- `samz_taste_products` — experimental product table

## Notes for Rust Backend
- No explicit foreign keys: join by natural keys (`receipt_no`, `product_code`, names). Expect data cleanliness issues.
- Build read models: create materialized views or ETL into Rust-owned Postgres for analytics.
- Use `log_table_sync_change` to incrementally mirror changes into the Rust store.
- Prefer `products.product_id` and add a stable `customers.customer_id` mapping if possible to avoid name-based joins.

## Minimal Entity Map (for APIs)
- Product(id, code, name, category, department, unit, prices, stock)
- Sale(id, receipt_no, product_code, qty, totals, customer)
- Receipt(id, receipt_no, totals, payment, customer)
- Customer(id, name, contact)
- Purchase(invoice, product, qty, cost)
