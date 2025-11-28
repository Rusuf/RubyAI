# File Structure Explanation

This document explains the purpose of each file in the `src/migration` module and the main `backfill.rs` binary.

### `src/backfill.rs`

This file is the main entry point for the data migration process. Its responsibilities are:

*   Establishing the connection to both the MySQL and PostgreSQL databases.
*   Orchestrating the migration process by calling the functions from the `migration` module.
*   Creating the necessary tables in the PostgreSQL database before the migration begins.

### `src/migration/mod.rs`

This file serves as the root of the `migration` module. It declares the sub-modules within this module, making them accessible to other parts of the application. In this case, it declares:

*   `pub mod product;`
*   `pub mod sale;`

### `src/migration/product.rs`

This file contains all the logic related to the migration of product data.

*   It defines the `Product` struct, which represents a product record from the database.
*   It contains the `migrate_products` function, which is responsible for querying the `products` table from MySQL and inserting the data into the `products` table in PostgreSQL.

### `src/migration/sale.rs`

This file is similar to `product.rs`, but for sales data.

*   It defines the `Sale` struct, which represents a sale record.
*   It contains the `migrate_sales` function, which handles the querying of sales data from MySQL and inserting it into the `sales` table in PostgreSQL.
