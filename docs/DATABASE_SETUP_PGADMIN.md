
# PostgreSQL Database Setup using pgAdmin

This guide provides a visual, step-by-step method for setting up your PostgreSQL database using the pgAdmin graphical interface.

## 1. Open pgAdmin

First, open the pgAdmin application. You can find it in your Windows Start Menu (it will be named something like `pgAdmin 4`).

## 2. Connect to Your Server

When pgAdmin opens, you will see a "Servers" entry in the browser panel on the left.

1.  Click on the arrow next to "Servers" to expand it.
2.  You will be prompted for the `postgres` user password you created during the PostgreSQL installation. Enter it to connect.

## 3. Create a New Database

1.  In the browser panel, right-click on **Databases** and select **Create** > **Database...**.
2.  In the "Database" field, type `ai_backend`.
3.  Click the **Save** button.

## 4. Create a New User (Login/Group Role)

Now, let's create a dedicated user for the AI backend.

1.  In the browser panel, right-click on **Login/Group Roles** (you may need to scroll down) and select **Create** > **Login/Group Role...**.
2.  In the **General** tab, enter `ai_user` in the "Name" field.
3.  Go to the **Definition** tab and enter a secure password in the "Password" field. Remember this password.
4.  Go to the **Privileges** tab and make sure the "Can login?" option is set to **Yes**.
5.  Click the **Save** button.

## 5. Grant Privileges to the New User

Now, we need to give `ai_user` permission to access the `ai_backend` database.

1.  In the browser panel, click on the `ai_backend` database to select it.
2.  Go to the top menu and select **Tools** > **Query Tool**.
3.  A new panel will open on the right. In the "Query Editor", paste the following command:

    ```sql
    GRANT ALL PRIVILEGES ON DATABASE ai_backend TO ai_user;
    ```

4.  Click the **Execute/Refresh** button (it looks like a lightning bolt or a play button).

## 6. Run the Initialization Script

Finally, let's create the tables in your new database.

1.  Make sure the `ai_backend` database is still selected and you have the **Query Tool** open.
2.  Open the `init.sql` file located at `C:\Users\HP\Ruby Restaurant\ai-backend\init.sql` in a text editor and copy its entire content.
3.  Paste the content into the **Query Editor** in pgAdmin (you can clear the previous `GRANT` command).
4.  Click the **Execute/Refresh** button to run the script. You should see a "Query returned successfully" message in the messages tab at the bottom.

## 7. Update Your Environment Variables

Your database is now ready. The final step is to update your `.env` file with the new credentials.

1.  If you haven't already, create a `.env` file in `C:\Users\HP\Ruby Restaurant\ai-backend` by copying `.env.example`.
2.  Update the `PG_DSN` in your `.env` file:

    ```
    PG_DSN=postgres://ai_user:your_password@localhost:5432/ai_backend
    ```

    Replace `your_password` with the password you created for `ai_user` in step 4.

Your database is now fully configured and ready for the AI backend. Please let me know once you have completed these steps.
