# Phase 1.1 Detailed Plan: Fixing Data Integrity Issues

This document provides a detailed, step-by-step guide for fixing the data integrity issues in the data pipeline. The primary goal is to ensure that foreign key relationships are correctly established in the PostgreSQL database.

## Task 1.1.1: Fix Foreign Key Lookups in `backfill.rs`

**Objective:** Correctly populate foreign keys during the initial data migration from MySQL to PostgreSQL.

### `migration/receipt.rs`

**File to modify:** `ai-backend/src/migration/receipt.rs`

**Current Problem:** The `customer_id` in the `receipts` table is not being populated because the `customer` from the source data is a string, not an ID.

**Detailed Steps:**

1.  **Modify `migrate_receipts` function signature:** The function needs access to the PostgreSQL client to perform the lookup. Change the signature from `pub async fn migrate_receipts(mysql_conn: &mut mysql::PooledConn, pg_client: &Client)` to `pub async fn migrate_receipts(mysql_conn: &mut mysql::PooledConn, pg_client: &tokio_postgres::Client)`.

2.  **Inside the `for receipt in receipts` loop:**
    *   **Look up `customer_id`:** Before inserting the receipt into PostgreSQL, you need to find the corresponding `customer_id`. You can do this by querying the `customers` table in PostgreSQL.
        *   **Query:** `SELECT customer_id FROM customers WHERE name = $1` or `email = $1`. You'll need to decide which field to use for the lookup. Using email is generally more reliable as it's more likely to be unique.
        *   **Code:**
            ```rust
            let customer_id: Option<i32> = {
                let row = pg_client.query_opt("SELECT customer_id FROM customers WHERE email = $1", &[&receipt.customer]).await?;
                row.map(|r| r.get(0))
            };
            ```
    *   **Handle missing customers:** If the customer is not found in the `customers` table, you need to decide how to handle it. You could either:
        *   **Skip the receipt:** Log a warning and skip inserting the receipt.
        *   **Insert with `NULL` `customer_id`:** This is the current behavior, but it's not ideal.
        *   **Create the customer:** You could insert the customer into the `customers` table and then get the new `customer_id`. This is the most robust approach.
    *   **Update the `INSERT` statement:** Modify the `INSERT` statement to use the `customer_id` you just looked up.

### `migration/sale.rs`

**File to modify:** `ai-backend/src/migration/sale.rs`

**Current Problem:** The `receipt_id` and `product_id` in the `sales` table are not being populated.

**Detailed Steps:**

1.  **Modify `migrate_sales` function signature:** The function needs access to the PostgreSQL client. Change the signature to `pub async fn migrate_sales(mysql_conn: &mut mysql::PooledConn, pg_client: &tokio_postgres::Client)`.

2.  **Inside the `for sale in sales` loop:**
    *   **Look up `receipt_id`:**
        *   **Query:** `SELECT receipt_id FROM receipts WHERE receipt_no = $1`.
        *   **Code:**
            ```rust
            let receipt_id: Option<i32> = {
                let row = pg_client.query_opt("SELECT receipt_id FROM receipts WHERE receipt_no = $1", &[&sale.receipt_no]).await?;
                row.map(|r| r.get(0))
            };
            ```
    *   **Look up `product_id`:**
        *   **Query:** `SELECT product_id FROM products WHERE product_code = $1`.
        *   **Code:**
            ```rust
            let product_id: Option<i32> = {
                let row = pg_client.query_opt("SELECT product_id FROM products WHERE product_code = $1", &[&sale.product_code]).await?;
                row.map(|r| r.get(0))
            };
            ```
    *   **Handle missing `receipt_id` or `product_id`:** If either the receipt or the product is not found, you should log a warning and skip inserting the sale.
    *   **Update the `INSERT` statement:** Modify the `INSERT` statement to use the `receipt_id` and `product_id` you just looked up.

## Task 1.1.2: Fix Foreign Key Lookups in `sync_changes.rs`

**Objective:** Correctly populate foreign keys during the continuous synchronization of data.

**File to modify:** `ai-backend/src/sync_changes.rs`

**Current Problem:** The same foreign key lookup issues from the backfill process also exist in the synchronization process.

**Detailed Steps:**

1.  **`apply_change` function:**
    *   **When `table_name` is `"receipts"`:**
        *   Before inserting or updating a receipt, perform the same `customer_id` lookup as in `migration/receipt.rs`.
    *   **When `table_name` is `"sales"`:**
        *   Before inserting or updating a sale, perform the same `receipt_id` and `product_id` lookups as in `migration/sale.rs`.

**Important Considerations:**

*   **Error Handling:** Make sure to handle potential errors during the lookup queries (e.g., database connection errors, query errors).
*   **Performance:** For the backfill process, it might be more efficient to fetch all the necessary data from the `customers`, `receipts`, and `products` tables into memory (e.g., into a `HashMap`) before starting the migration. This would avoid making a separate database query for each row to be inserted. However, this approach depends on the size of the data. For the synchronization process, individual lookups are likely fine as the number of changes is expected to be small.
*   **Code Duplication:** The lookup logic will be similar in both the backfill and synchronization scripts. You might consider creating a shared module to avoid code duplication.