# Proposed Development Plan

This document outlines a detailed plan for the next phases of the AI backend development, based on the initial `Dev.md` document and an analysis of the existing codebase.

## Phase 1: Solidify the Data Foundation (1-2 weeks)

The current data pipeline is a good start, but it has some critical issues that need to be addressed before we can build the AI features on top of it. This phase focuses on making the data pipeline robust, reliable, and production-ready.

### 1.1. Fix Data Integrity Issues

**Problem:** The current data migration and synchronization scripts do not correctly handle foreign key relationships. This results in `null` values for `customer_id`, `receipt_id`, and `product_id` in the PostgreSQL database, rendering the data unusable for analysis.

**Solution:**

*   **In `backfill.rs` and `sync_changes.rs`:**
    *   When migrating or synchronizing a `receipt`, look up the `customer_id` from the `customers` table based on the customer information in the source data.
    *   When migrating or synchronizing a `sale`, look up the `receipt_id` from the `receipts` table and the `product_id` from the `products` table.

### 1.2. Refactor the Data Pipeline with `sqlx`

**Problem:** The current implementation uses raw SQL strings, which is error-prone and hard to maintain. It also uses two different database libraries (`mysql` and `tokio-postgres`), which adds unnecessary complexity.

**Solution:**

*   **Adopt `sqlx`:** Refactor the data pipeline to use the `sqlx` crate for all database interactions. `sqlx` provides several advantages:
    *   **Compile-time checked queries:** This will prevent SQL errors at runtime.
    *   **Async support:** `sqlx` is designed for asynchronous applications.
    *   **Connection pooling:** `sqlx` has built-in connection pooling.
    *   **Consistent API:** Use a single library for both MySQL and PostgreSQL.

*   **Implementation Steps:**
    1.  Add `sqlx` as a dependency in `Cargo.toml` with the `runtime-tokio-rustls`, `mysql`, `postgres`, and `chrono` features.
    2.  Update the data models in `db_models/src/lib.rs` to derive `sqlx::FromRow`.
    3.  Replace the database connection logic in `backfill.rs` and `sync_changes.rs` with `sqlx::PgPool` and `sqlx::MySqlPool`.
    4.  Rewrite all SQL queries using the `sqlx::query!` or `sqlx::query_as!` macros.

### 1.3. Improve Synchronization Efficiency

**Problem:** The current synchronization process is inefficient as it processes changes one by one.

**Solution:**

*   **Batch Processing:** Modify the `sync_changes.rs` script to process changes in batches. This will significantly reduce the number of database queries and improve performance.

### 1.4. Add Comprehensive Testing

**Problem:** The lack of tests makes it difficult to ensure the correctness of the data pipeline.

**Solution:**

*   **Integration Tests:** Use a library like `testcontainers-rs` to create integration tests that spin up real MySQL and PostgreSQL databases in Docker. These tests should cover the entire data pipeline, from migration to synchronization.
*   **Unit Tests:** Write unit tests for individual functions, such as the foreign key lookup logic.

## Phase 2: Implement the Recommendation Engine (2-3 weeks)

Once the data foundation is solid, we can start building the first AI feature: the recommendation engine.

### 2.1. API Endpoint

*   Create a new API endpoint: `GET /api/recommendations/{menu_item_id}`.

### 2.2. Recommendation Logic

*   **Algorithm:** Start with the **Apriori algorithm** to find frequently co-purchased items. This is a good starting point for "people who bought this also bought..." recommendations.
*   **Implementation:**
    1.  Use the `apriori` crate in Rust.
    2.  The API endpoint will take a `menu_item_id` as input.
    3.  Query the `sales` and `receipts` tables in the PostgreSQL database to get the transaction data.
    4.  Use the Apriori algorithm to find association rules.
    5.  Return a list of recommended items in the API response.

### 2.3. Research for Future Enhancements

For more advanced recommendations, we can explore:

*   **Collaborative Filtering:** Use techniques like matrix factorization (e.g., with the `linfa` crate) to find users with similar tastes.
*   **Content-Based Filtering:** Recommend items based on their attributes (e.g., ingredients, category).
*   **Hybrid Models:** Combine collaborative and content-based filtering for more accurate recommendations.

## Phase 3: Implement Stock Optimization (2-3 weeks)

This phase focuses on building a predictive model to optimize stock levels.

### 3.1. API Endpoint

*   Create a new API endpoint: `GET /api/stock_optimization`.

### 3.2. Predictive Model

*   **Algorithm:** Start with a simple time series forecasting model, such as **linear regression** or **moving averages**, to predict future demand for each product.
*   **Implementation:**
    1.  Use a crate like `linfa` for the forecasting model.
    2.  The model will use historical sales data from the PostgreSQL database.
    3.  The API endpoint will return a prioritized list of ingredients and suggested stock levels.

### 3.3. Research for Future Enhancements

*   **More Advanced Models:** Explore more sophisticated time series models like ARIMA or Prophet for more accurate forecasts.
*   **External Data:** Incorporate external data, such as holidays and weather forecasts, to improve the accuracy of the predictions.

## Phase 4: Implement Trend Discovery (3-4 weeks)

This phase involves building a system to discover trending recipes from the internet.

### 4.1. Web Scraping and Data Collection

*   **Tools:** Use `reqwest` for making HTTP requests and `scraper` for parsing HTML.
*   **Sources:** Target food blogs, recipe websites, and social media platforms.
*   **Implementation:** Build a resilient web scraper that can handle different website structures and avoid getting blocked.

### 4.2. NLP and Trend Analysis

*   **Tools:** Use a crate like `rust-bert` for NLP tasks such as named entity recognition and text classification.
*   **Implementation:**
    1.  Extract key information from the scraped data, such as dish names, ingredients, and cooking instructions.
    2.  Use NLP to analyze the text and identify trending topics.

### 4.3. API Endpoint

*   Create a new API endpoint: `GET /api/trending_recipes`.

This plan provides a clear roadmap for the next stages of development. By focusing on solidifying the data foundation first, we can ensure that the subsequent AI features are built on a reliable and accurate dataset.