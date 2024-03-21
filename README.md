# rust-api-samples-axum
Implement Rust API with Axum.

## local database
```bash
sudo apt-get update
sudo apt-get install -y postgresql-client
PGPASSWORD=postgres psql -h db -p  5432 -U postgres -d postgres
psql -h db -p  5432 -U postgres -d postgres
```

```bash
@danny-yamamoto ➜ /workspaces/rust-api-samples-axum (main) $ PGPASSWORD=postgres psql -h db -p  5432 -U postgres -d postgres
psql (13.14 (Debian 13.14-0+deb11u1), server 14.1 (Debian 14.1-1.pgdg110+1))
WARNING: psql major version 13, server major version 14.
         Some psql features might not work.
Type "help" for help.

postgres=# \q
@danny-yamamoto ➜ /workspaces/rust-api-samples-axum (main) $
```
