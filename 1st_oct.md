# Plan for October 1st: Connecting to the Live Database

Our goal is to get your AI backend successfully reading data from the main restaurant's **live** MySQL database and saving it into your new PostgreSQL database.

Here is your updated step-by-step checklist.

---

### ✅ **Step 1: Get Live Database Credentials**

Since the database is already live, you do not need to create it. Instead, you need to get the connection details from whoever manages the restaurant's IT systems.

- [ ] **Request the following information for the live MySQL database:**
    - **Hostname** (or IP Address)
    - **Username**
    - **Password**
    - **Port** (if it's not the default `3306`)

**Security Note:** It is highly recommended to ask for a **read-only** user account. This will prevent your AI backend from accidentally modifying any live restaurant data.

---

### ✅ **Step 2: Configure Your AI Backend's Environment**

Now, let's make sure your Rust application knows how to connect to both the live MySQL database and your local PostgreSQL database.

- [ ] **Open the `.env` file:** Open the file at `C:\Users\HP\Ruby Restaurant\ai-backend\.env`.
- [ ] **Update PostgreSQL Password:**
    - Find the line: `PG_DSN=postgres://ai_user:your_postgres_password@localhost:5432/ai_backend`
    - Replace `your_postgres_password` with the real password you set for the `ai_user`.
- [ ] **Update the MySQL Connection String:**
    - Find the line starting with `MYSQL_DSN=...`
    - Replace it with the credentials you received in Step 1. The format is:
    ```
    MYSQL_DSN=mysql://USERNAME:PASSWORD@HOSTNAME:PORT/essayhar_ruby
    ```
    - For example: `MYSQL_DSN=mysql://ai_readonly_user:a_very_secure_password@192.168.1.100:3306/essayhar_ruby`

**Acceptance Criteria:** The `.env` file contains the correct, working credentials for both your PostgreSQL and the live MySQL databases.

---

### ✅ **Step 3: Run the AI Backend to Ingest Data**

Once the configuration is correct, you can run the application to start pulling data.

- [ ] **Open a terminal** in the `ai-backend` directory.
- [ ] **Run the application:**
    ```bash
    cargo run
    ```

**Acceptance Criteria:** The application starts without crashing. You should see log messages in your terminal indicating that it is connecting to both databases and starting the data ingest process.

---

### ✅ **Step 4: Verify the Data in PostgreSQL**

After the application has been running for a few minutes, check if the data has been copied into your `ai_backend` PostgreSQL database.

- [ ] **Open pgAdmin.**
- [ ] **Connect** to your server and open the `ai_backend` database.
- [ ] **View Table Data:**
    1. In the browser panel on the left, navigate to `ai_backend` > **Schemas** > **public** > **Tables**.
    2. You should see the tables: `products`, `sales`, and `receipts`.
    3. Right-click on the `products` table and select **"View/Edit Data"** > **"All Rows"**.

**Acceptance Criteria:** You see rows of product data being copied from the live database into your local PostgreSQL `products` table.
