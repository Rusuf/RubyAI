PS C:\Users\HP\Ruby Restaurant\ai-backend> cargo run
   Compiling ai-backend v0.1.0 (C:\Users\HP\Ruby Restaurant\ai-backend)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 5.87s
warning: the following packages contain code that will be rejected by a future version of Rust: argmin v0.4.7
note: to see what the problems were, use the option `--future-incompat-report`, or run `cargo report future-incompatibilities --id 1`
     Running `target\debug\ai-backend.exe`
Training recommendation model on server startup...
Starting recommendation model training...
Apriori algorithm generated 22 rules.
Recommendation model training complete.
Recommendation model is ready.

ðŸš€ Starting Actix web server at http://127.0.0.1:8080
[2025-10-02T08:26:00Z INFO  actix_server::builder] starting 8 workers
[2025-10-02T08:26:00Z INFO  actix_server::server] Actix runtime found; starting in Actix runtime
[2025-10-02T08:26:00Z INFO  actix_server::server] starting service: "actix-web-service-127.0.0.1:8080", workers: 8, listening on: 127.0.0.1:8080

ðŸ”„ Running periodic database synchronization...
[2025-10-02T08:26:03Z WARN  sqlx::query] slow statement: execution time exceeded alert threshold summary="SELECT id, table_name, primary_key_value …" db.statement="\n\nSELECT\n  id,\n  table_name,\n  primary_key_value\nFROM\n  log_table_sync_change\nWHERE\n  status = 'pending'\nORDER BY\n  change_time ASC\n" rows_affected=0 rows_returned=0 elapsed=1.631969s elapsed_secs=1.631969 slow_threshold=1s
   No new changes found.
ðŸ›Œ Synchronization check complete.
