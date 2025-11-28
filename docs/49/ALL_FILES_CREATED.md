# All Files Created and Modified

This document provides a detailed explanation of all the files that were created or significantly modified during the development of the data pipeline.

## Core Application Files

### `src/backfill.rs`

*   **Purpose:** This is the main entry point for the one-time data migration. It is responsible for orchestrating the entire backfill process.
*   **Functionality:**
    *   Connects to both MySQL and PostgreSQL databases.
    *   Calls the functions from the `migration` module to create the tables and migrate the data for each table.

### `src/sync_changes.rs`

*   **Purpose:** This is the main entry point for the continuous data synchronization service.
*   **Functionality:**
    *   Runs in a loop, checking for changes every 30 minutes.
    *   Connects to both databases.
    *   Queries the `log_table_sync_change` table for new changes.
    *   Calls the `apply_change` function to process the changes.

## `db_models` Library

This is a shared library that contains the data structures for the database models. This approach avoids code duplication and ensures consistency between the `backfill` and `sync_changes` binaries.

### `db_models/Cargo.toml`

*   **Purpose:** The manifest file for the `db_models` library.
*   **Functionality:** Defines the package information and its dependencies (`serde`, `chrono`, `mysql`).

### `db_models/src/lib.rs`

*   **Purpose:** The root file of the `db_models` library.
*   **Functionality:** Defines the public data structures (`Customer`, `Product`, `Receipt`, `Sale`) that are shared across the workspace.

## `migration` Module

This module contains the logic for the one-time data migration, broken down by table.

### `src/migration/mod.rs`

*   **Purpose:** The root of the `migration` module.
*   **Functionality:** Declares the sub-modules (`customer`, `product`, `receipt`, `sale`).

### `src/migration/customer.rs`

*   **Purpose:** Handles the migration of customer data.
*   **Functionality:** Defines the `migrate_customers` function, which queries the `customers` table from MySQL and inserts the data into the `customers` table in PostgreSQL.

### `src/migration/product.rs`

*   **Purpose:** Handles the migration of product data.
*   **Functionality:** Defines the `migrate_products` function.

### `src/migration/receipt.rs`

*   **Purpose:** Handles the migration of receipt data.
*   **Functionality:** Defines the `migrate_receipts` function.

### `src/migration/sale.rs`

*   **Purpose:** Handles the migration of sales data.
*   **Functionality:** Defines the `migrate_sales` function.

## Temporary Scripts

These scripts were created for temporary tasks and have since been deleted.

### `src/nuke_db.rs`

*   **Purpose:** To drop all tables from the PostgreSQL database to ensure a clean slate for the final migration.

### `src/discover_schema.rs`

*   **Purpose:** To inspect the MySQL database and print the schema of the key tables. This was crucial for planning the data migration strategy.

## Documentation

All documentation files are located in the `ai-backend/49/` directory.

*   `IMPLEMENTATION_PLAN.md`
*   `FILE_STRUCTURE.md`
*   `DATA_EXPLORATION_PLAN.md`
*   `POSTGRES_SCHEMA_AND_MIGRATION_PLAN.md`
*   `WHAT_HAS_BEEN_DONE.md`
*   `ALL_FILES_CREATED.md`
