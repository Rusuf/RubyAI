# PostgreSQL Schema and Migration Plan

This document outlines the proposed PostgreSQL schema and the strategy for migrating data from the MySQL database. This plan is based on the requirements from `Dev.md` and the actual schema discovered from the MySQL database.

## 1. Objective

The goal is to create a clean, optimized, and analytics-friendly data warehouse in PostgreSQL. This database will serve as the primary data source for the AI and recommendation engine, so the schema must be designed for efficient querying and analysis.

## 2. Proposed PostgreSQL Schema

The following schema is proposed for the PostgreSQL database. This schema cleans up data types, establishes clear relationships with foreign keys, and focuses on the data needed for the AI service.

### `products` table

Stores the product catalog.

| Column          | Data Type      | Notes                               |
|-----------------|----------------|-------------------------------------|
| `product_id`    | `INTEGER`      | Primary Key                         |
| `product_code`  | `VARCHAR(100)` | Unique                              |
| `name`          | `VARCHAR(100)` |                                     |
| `department`    | `VARCHAR(100)` |                                     |
| `category`      | `VARCHAR(100)` |                                     |
| `selling_price` | `REAL`         | Converted from `varchar`            |
| `current_stock` | `REAL`         | Converted from `varchar`            |

### `customers` table

Stores customer information.

| Column          | Data Type      | Notes                               |
|-----------------|----------------|-------------------------------------|
| `customer_id`   | `INTEGER`      | Primary Key                         |
| `name`          | `VARCHAR(100)` |                                     |
| `email`         | `VARCHAR(100)` |                                     |
| `registered_on` | `TIMESTAMP`    |                                     |

### `receipts` table

Stores transaction-level information.

| Column           | Data Type      | Notes                               |
|------------------|----------------|-------------------------------------|
| `receipt_id`     | `INTEGER`      | Primary Key                         |
| `receipt_no`     | `INTEGER`      |                                     |
| `transaction_date` | `TIMESTAMP`    |                                     |
| `customer_id`    | `INTEGER`      | Foreign Key to `customers.customer_id` |
| `total_amount`   | `REAL`         | Converted from `varchar`            |
| `payment_channel`| `VARCHAR(100)` |                                     |

### `sales` table

Stores individual sale items, forming the core of the historical order data.

| Column          | Data Type      | Notes                               |
|-----------------|----------------|-------------------------------------|
| `sale_id`       | `INTEGER`      | Primary Key                         |
| `receipt_id`    | `INTEGER`      | Foreign Key to `receipts.receipt_id` |
| `product_id`    | `INTEGER`      | Foreign Key to `products.product_id`   |
| `quantity`      | `REAL`         |                                     |
| `selling_price` | `REAL`         |                                     |
| `total_sale`    | `REAL`         |                                     |

## 3. Migration Strategy

The `backfill.rs` script will be rewritten to implement the following migration logic in a modular and maintainable way.

1.  **Create Tables:** The script will first create the new tables in PostgreSQL with the schema defined above.

2.  **Migrate `customers`:** The `customers` table will be migrated first to ensure that `customer_id`s are available for foreign key references.

3.  **Migrate `products`:** The `products` table will be migrated. The script will handle the conversion of `sellingprice` and `current_stock` from `varchar` to `REAL`.

4.  **Migrate `receipts`:** The `receipts` table will be migrated. The script will need to handle looking up the `customer_id` from the newly populated `customers` table.

5.  **Migrate `sales`:** The `sales` table will be migrated last. For each sale, the script will need to:
    *   Look up the `receipt_id` from the `receipts` table based on the `receipt_no`.
    *   Look up the `product_id` from the `products` table based on the `product_code`.
    *   This may involve building in-memory maps (e.g., `HashMap<String, i32>`) for `product_code` -> `product_id` and `receipt_no` -> `receipt_id` to ensure efficient lookups.

## 4. Implementation Structure

The `backfill.rs` script will be the entry point, and the migration logic will be organized into a `migration` module with sub-modules for each table (`product.rs`, `sale.rs`, `customer.rs`, `receipt.rs`). This will ensure the code is clean, maintainable, and follows Rust best practices.
