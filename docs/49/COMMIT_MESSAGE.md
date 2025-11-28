feat: Implement initial data pipeline for AI service

This commit introduces the initial data pipeline for the AI service, which includes a one-time data migration script and a continuous synchronization service.

Key features and changes:

- **One-Time Data Migration (`backfill.rs`):**
  - A new binary, `backfill`, has been created to perform a one-time migration of data from the MySQL database to the PostgreSQL database.
  - The script creates a clean, optimized schema in PostgreSQL for the `customers`, `products`, `receipts`, and `sales` tables.

- **Continuous Synchronization (`sync_changes.rs`):**
  - A new binary, `sync_changes`, has been implemented to keep the PostgreSQL database up-to-date with the MySQL database in near real-time.
  - The service runs continuously, checking for changes in the `log_table_sync_change` table every 30 minutes and applying them to the PostgreSQL database.

- **Shared `db_models` Library:**
  - A new library, `db_models`, has been created to hold the shared data structures (`Customer`, `Product`, etc.).
  - This eliminates code duplication and ensures consistency between the `backfill` and `sync_changes` binaries.

- **Modular Structure:**
  - The `backfill` script has been refactored into a modular structure with a `migration` module, making the code more maintainable and easier to understand.

- **Documentation:**
  - Comprehensive documentation, including implementation plans and file structure explanations, has been added to the `ai-backend/49/` directory.
