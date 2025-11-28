# Implementation Plan: Data Migration for AI Backend

## 1. Objective

As outlined in `Dev.md`, the primary goal of the AI service is to provide recommendations and market intelligence. To achieve this, the service needs access to core business data.

This implementation plan details the steps required to modify the `backfill.rs` script to populate a PostgreSQL database with the necessary data from the MySQL database. This will provide the foundational dataset for developing and training the recommendation and trend analysis models.

## 2. Data Requirements

Based on the roadmap in `Dev.md` and the database schema, the following data is critical for the AI service:

*   **Product Data:** To understand the items available for sale, their pricing, and inventory levels.
    *   **Source Table:** `products` in MySQL.
    *   **Target Table:** `products` in PostgreSQL.
*   **Sales Data:** To analyze historical sales patterns, identify top-selling items, and understand customer purchasing behavior.
    *   **Source Table:** `sales` in MySQL.
    *   **Target Table:** `sales` in PostgreSQL.

The existing customer data migration will be preserved, but the focus of this implementation is to add the product and sales data.

## 3. Implementation Steps

The `backfill.rs` script will be updated to perform the following actions:

1.  **Define Data Structures:**
    *   Create a `Product` struct in Rust to represent the data from the `products` table.
    *   Create a `Sale` struct in Rust to represent the data from the `sales` table.

2.  **Create PostgreSQL Tables:**
    *   On startup, the script will connect to the PostgreSQL database and execute `CREATE TABLE IF NOT EXISTS` statements for the `products` and `sales` tables. This ensures the target tables are always available.

3.  **Implement Data Migration Logic:**
    *   **Products:**
        *   Query the `products` table in MySQL to retrieve all product records.
        *   Iterate through the retrieved products.
        *   For each product, execute an `INSERT ... ON CONFLICT` statement to insert or update the record in the `products` table in PostgreSQL. This makes the migration process idempotent.
    *   **Sales:**
        *   Query the `sales` table in MySQL to retrieve all sales records.
        *   Iterate through the retrieved sales.
        *   For each sale, execute an `INSERT ... ON CONFLICT` statement to insert or update the record in the `sales` table in PostgreSQL.

## 4. Expected Outcome

Upon successful execution of the updated `backfill.rs` script, the PostgreSQL database will contain three tables:

*   `users` (from the previous implementation)
*   `products`
*   `sales`

These tables will be populated with the corresponding data from the MySQL database, providing a clean and accessible data source for the Rust AI service to begin its analysis and recommendation tasks.
