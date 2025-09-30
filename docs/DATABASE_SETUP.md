
# PostgreSQL Database Setup for the AI Backend

This guide provides step-by-step instructions for setting up a new PostgreSQL database for the AI backend.

## 1. Install PostgreSQL

If you don't have PostgreSQL installed, you'll need to install it first.

1.  **Download PostgreSQL:** Go to the [official PostgreSQL website](https://www.postgresql.org/download/) and download the installer for your operating system. For Windows, the EDB installer is recommended.
2.  **Install PostgreSQL:** Run the installer and follow the on-screen instructions. During the installation, you will be prompted to set a password for the `postgres` superuser. **Remember this password.**

## 2. Create the Database and User

Next, you'll create a new database and a dedicated user for the AI backend. Using a dedicated user is a good security practice.

1.  **Open the SQL Shell (psql):** After the installation is complete, open the `SQL Shell (psql)` application. You can find it in the Start Menu under the PostgreSQL folder.
2.  **Connect to the default database:** When prompted, press Enter to accept the default values for Server, Database, Port, and Username. Enter the `postgres` user password you set during installation.
3.  **Create the database:** Run the following SQL command to create a new database named `ai_backend`:

    ```sql
    CREATE DATABASE ai_backend;
    ```

4.  **Create a new user:** Run the following command to create a new user named `ai_user` with a password. Replace `'your_password'` with a strong password.

    ```sql
    CREATE USER ai_user WITH PASSWORD 'your_password';
    ```

5.  **Grant privileges:** Grant all privileges on the `ai_backend` database to the `ai_user`:

    ```sql
    GRANT ALL PRIVILEGES ON DATABASE ai_backend TO ai_user;
    ```

6.  **Exit psql:** You can now exit `psql` by typing `\q` and pressing Enter.

## 3. Update Your Environment Variables

Now that you have a new database and user, you need to update the `PG_DSN` (PostgreSQL Data Source Name) in your `.env` file.

1.  **Create a `.env` file:** In the `C:\Users\HP\Ruby Restaurant\ai-backend` directory, create a new file named `.env`.
2.  **Copy the content from `.env.example`:** Copy the content from `.env.example` into your new `.env` file.
3.  **Update the `PG_DSN`:** Modify the `PG_DSN` to match your new database settings. It should look like this:

    ```
    PG_DSN=postgres://ai_user:your_password@localhost:5432/ai_backend
    ```

    Replace `your_password` with the password you set for the `ai_user`.

## 4. Run the Initialization Script

Now you are ready to create the tables in your new database. You can run the `init.sql` script I created earlier.

If you have `psql` in your system's PATH, you can run the following command in your terminal:

```bash
psql -d ai_backend -U ai_user -a -f "C:\Users\HP\Ruby Restaurant\ai-backend\init.sql"
```

You will be prompted for the password for the `ai_user`.

After you have completed these steps, your PostgreSQL database will be ready for the AI backend. Let me know when you are done, and I will proceed with the backfill script.
