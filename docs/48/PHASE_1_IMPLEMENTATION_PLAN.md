# Phase 1 Implementation Plan: Solidifying the Data Foundation

This document provides a detailed, step-by-step implementation plan for Phase 1 of the AI backend development. The goal of this phase is to create a robust, reliable, and production-ready data pipeline.

## 1.1. Fix Data Integrity Issues

**Objective:** Ensure that foreign key relationships are correctly established in the PostgreSQL database during both the initial data migration and the continuous synchronization process.

### Task 1.1.1: Fix Foreign Key Lookups in `backfill.rs`

**File to modify:** `ai-backend/src/migration/*.rs`

1.  **`migration/customer.rs`:** No changes are needed here as `customers` is the primary table.

2.  **`migration/product.rs`:** No changes are needed here as `products` is also a primary table.

3.  **`migration/receipt.rs`:**
    *   **Logic:** Before inserting a receipt, query the `customers` table in PostgreSQL to find the `customer_id` for the corresponding customer.
    *   **Implementation:** You'll need to pass the `pg_client` to the `migrate_receipts` function. Inside the loop, before inserting a receipt, perform a `SELECT customer_id FROM customers WHERE name = $1` or `email = $1` to get the `customer_id`.

4.  **`migration/sale.rs`:**
    *   **Logic:** Before inserting a sale, query the `receipts` and `products` tables in PostgreSQL to find the `receipt_id` and `product_id`.
    *   **Implementation:** Inside the loop, before inserting a sale, perform a `SELECT receipt_id FROM receipts WHERE receipt_no = $1` to get the `receipt_id`, and `SELECT product_id FROM products WHERE product_code = $1` to get the `product_id`.

### Task 1.1.2: Fix Foreign Key Lookups in `sync_changes.rs`

**File to modify:** `ai-backend/src/sync_changes.rs`

1.  **`apply_change` function:**
    *   **For `receipts` table:** When processing a change for the `receipts` table, look up the `customer_id` from the `customers` table in PostgreSQL based on the customer information in the `receipt` row from MySQL.
    *   **For `sales` table:** When processing a change for the `sales` table, look up the `receipt_id` from the `receipts` table and the `product_id` from the `products` table in PostgreSQL.

## 1.2. Refactor the Data Pipeline with `sqlx`

**Objective:** Replace the `mysql` and `tokio-postgres` crates with `sqlx` to improve type safety, maintainability, and consistency.

### Task 1.2.1: Update `Cargo.toml`

1.  **`ai-backend/Cargo.toml`:**
    *   Add `sqlx = { version = "0.7", features = [ "runtime-tokio-rustls", "mysql", "postgres", "chrono" ] }`
    *   Remove `mysql` and `tokio-postgres`.
2.  **`ai-backend/db_models/Cargo.toml`:**
    *   Add `sqlx = { version = "0.7", features = [ "runtime-tokio-rustls", "macros" ] }`
    *   Remove `mysql`.

### Task 1.2.2: Update Data Models

**File to modify:** `ai-backend/db_models/src/lib.rs`

1.  Replace `use mysql::prelude::FromRow;` with `use sqlx::FromRow;`.
2.  Add `#[derive(sqlx::FromRow)]` to all the structs.

### Task 1.2.3: Refactor `backfill.rs`

1.  Replace the `connect_mysql` and `connect_postgres` functions with `sqlx::MySqlPool::connect` and `sqlx::PgPool::connect`.
2.  Rewrite all `mysql_conn.query_map` and `pg_client.execute` calls with `sqlx::query!` or `sqlx::query_as!`.

### Task 1.2.4: Refactor `sync_changes.rs`

1.  Replace the `connect_mysql` and `connect_postgres` functions with `sqlx` connection pools.
2.  Rewrite all database queries using `sqlx` macros.

## 1.3. Improve Synchronization Efficiency

**Objective:** Improve the performance of the synchronization process by processing changes in batches.

### Task 1.3.1: Batch Processing in `sync_changes.rs`

1.  **`process_changes` function:**
    *   Fetch all pending changes from the `log_table_sync_change` table.
    *   Group the changes by table (`customers`, `products`, `receipts`, `sales`).
    *   For each table, construct a single `INSERT ... ON CONFLICT DO UPDATE` statement to update all the changed rows in a single query. This can be done by generating a query with multiple `VALUES` clauses.

## 1.4. Add Comprehensive Testing

**Objective:** Create a suite of tests to ensure the data pipeline is reliable and correct.

### Task 1.4.1: Set up Testing Framework

1.  Add `testcontainers-rs` to the `dev-dependencies` in `ai-backend/Cargo.toml`.
2.  Create a new `tests` directory in `ai-backend`.

### Task 1.4.2: Write Integration Tests

**File to create:** `ai-backend/tests/data_pipeline.rs`

1.  **Test Case 1: Backfill**
    *   Use `testcontainers-rs` to start MySQL and PostgreSQL containers.
    *   Create the necessary tables in both databases.
    *   Insert sample data into the MySQL database.
    *   Run the `backfill` script.
    *   Query the PostgreSQL database to verify that the data has been migrated correctly, including the foreign key relationships.

2.  **Test Case 2: Synchronization**
    *   Start with the state from the backfill test.
    *   Insert, update, and delete data in the MySQL database.
    *   Add corresponding entries to the `log_table_sync_change` table.
    *   Run the `sync_changes` script.
    *   Query the PostgreSQL database to verify that the changes have been synchronized correctly.

### Task 1.4.3: Write Unit Tests

*   Create unit tests for individual functions, such as the foreign key lookup logic, to ensure they handle various scenarios correctly (e.g., what happens if a customer is not found).