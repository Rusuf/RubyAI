# Phase 2 Implementation Plan: Internal Intelligence

## 1. Overview

This document outlines the implementation strategy for Phase 2 of the AI Backend project. The primary objective of this phase is to activate the service's internal intelligence capabilities by leveraging the newly migrated PostgreSQL data. 

We will adopt a pragmatic and iterative approach, focusing on delivering robust, baseline models for our two core features: **Recommendations** and **Stock Optimization**. The architecture will be designed for future enhancement while ensuring we deliver value quickly.

---

## 2. Feature 1: Recommendation Engine

**Objective:** Implement a "Frequently Bought Together" recommendation system. This feature will provide suggestions for complementary items based on historical transaction data.

**Technical Approach:** We will proceed with the **Apriori algorithm** for association rule mining. This is a well-understood, robust algorithm that directly addresses the objective. Its implementation is straightforward with the `apriori-pattern-miner` crate, and its performance is more than adequate for our current dataset size. This approach minimizes initial complexity while providing a solid foundation for more advanced recommendation strategies (e.g., collaborative filtering) in future phases.

### Task Breakdown

1.  **Data ETL (Extract, Transform, Load):**
    *   **Task:** Develop a data loading module within `recommendations.rs`.
    *   **Action:** Implement a function to connect to the PostgreSQL database and execute a query that groups `product_id`s by `receipt_id`.
    *   **Output:** The function must produce a `Vec<Vec<i32>>`, representing the list of transactions required by the Apriori crate.

2.  **Model Training (Background Task):**
    *   **Task:** Create an asynchronous, periodic task to run the Apriori analysis.
    *   **Action:** This task will use the ETL output to run the `apriori-pattern-miner`. Key parameters (`min_support`, `min_confidence`) will be configurable. The initial values will be set to `0.01` and `0.5` respectively, subject to tuning.
    *   **Rationale:** Training is decoupled from the API request/response cycle to ensure low-latency API performance. This task can be a separate binary or a `tokio::spawn`ed task that runs on a schedule (e.g., nightly).

3.  **Serving Strategy:**
    *   **Task:** Implement a low-latency cache for serving the generated rules.
    *   **Action:** The output of the training task (the association rules) will be transformed into a `HashMap<i32, Vec<i32>>`. This map will store a `product_id` as the key and a list of recommended `product_id`s as the value.
    *   **Integration:** This `HashMap` will be loaded into the Actix-web application state (`web::Data`) at startup, making it instantly accessible to all API handlers.

4.  **API Endpoint Integration:**
    *   **Task:** Wire the recommendation cache to the public API.
    *   **Action:** The `get_recommendations` handler in `main.rs` will be updated to perform a simple key-value lookup in the `HashMap` from the application state. It will return the list of recommended product IDs as a JSON response.

---

## 3. Feature 2: Stock Optimization Forecast

**Objective:** Provide predictive re-stocking suggestions for top-selling items based on historical sales velocity.

**Technical Approach:** We will begin with a **per-product Linear Regression model**. This is a pragmatic first step that establishes a baseline forecasting capability. It allows us to build the full data pipeline, from data extraction to prediction, without getting bogged down in complex modeling. The `linfa` and `linfa-linear` crates provide all necessary components.

This baseline can be improved in future iterations by graduating to more sophisticated models (e.g., Gradient Boosting with time-based features) once the core pipeline is validated.

### Task Breakdown

1.  **Data ETL:**
    *   **Task:** Develop a data loading module within `stock_optimization.rs`.
    *   **Action:** Implement a function to query the PostgreSQL database to produce a sales time series. The query will aggregate `quantity` sold per `product_id` by `day`.
    *   **Output:** A data structure containing a list of `(date, product_id, total_quantity)` records.

2.  **Model Training (Background Task):**
    *   **Task:** Create a task to train a separate regression model for each of our top N products.
    *   **Action:** For each product, generate a feature set where `X` is the time index (e.g., "day number") and `y` is the `total_quantity`. Use `linfa_linear::LinearRegression` to fit a model to this data. The trained model objects should be serialized and saved to disk.

3.  **Forecasting and Suggestion Logic:**
    *   **Task:** Implement the business logic for generating stock suggestions.
    *   **Action:** When the API is called, the service will load the pre-trained models. It will then:
        1.  Use the `.predict()` method to forecast sales for the next 7 days.
        2.  Fetch the `current_stock` for the item from the database.
        3.  Calculate the suggested re-order quantity using the formula: `reorder_qty = (forecast * safety_factor) - current_stock`.
        4.  The `safety_factor` will be a configurable value, starting at `1.2`.

4.  **API Endpoint Integration:**
    *   **Task:** Connect the forecasting logic to the public API.
    *   **Action:** The `get_stock_optimization` handler in `main.rs` will orchestrate the process of loading models, generating forecasts, and calculating suggestions. It will return a prioritized JSON list of items that require re-stocking.

---

## 4. Definition of Done

Phase 2 will be considered complete when:

*   The `backfill` command runs to completion without errors.
*   The recommendation training task successfully generates and loads rules into the application state.
*   The `GET /api/recommendations/{product_id}` endpoint returns a valid, non-empty JSON array of product IDs for at least 50% of top-selling items.
*   The stock optimization training task successfully trains and saves models for the top 20 products.
*   The `GET /api/stock_optimization` endpoint returns a valid JSON array of products to re-stock.
*   All new logic is covered by unit and/or integration tests.
