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

```bash
# ssh -i location_of_pem_file ec2-user@ec2-instance-public-dns-name
ssh -i local.pem ec2-user@ec2-x-x-x-x.compute-1.amazonaws.com
```

```bash
# psql --host=endpoint --port=5432 --dbname=postgres --username=postgres
psql --host=database-test1.hogehoge.us-east-1.rds.amazonaws.com --port=5432 --dbname=postgres --username=postgres
```

```bash
@danny-yamamoto ➜ /workspaces/rust-api-samples-axum (main) $ ssh -i local.pem ec2-user@ec2-x-x-x-x.compute-1.amazonaws.com
   ,     #_
   ~\_  ####_        Amazon Linux 2023
  ~~  \_#####\
  ~~     \###|
  ~~       \#/ ___   https://aws.amazon.com/linux/amazon-linux-2023
   ~~       V~' '->
    ~~~         /
      ~~._.   _/
         _/ _/
       _/m/'
Last login: Fri Mar 22 00:45:47 2024 from x.x.x.x
[ec2-user@ip-172-31-24-240 ~]$ psql --host=database-test1.hogehoge.us-east-1.rds.amazonaws.com --port=5432 --dbname=postgres --username=postgres
Password for user postgres: 
[ec2-user@ip-172-31-24-240 ~]$ 
[ec2-user@ip-172-31-24-240 ~]$ psql --host=database-test1.hogehoge.us-east-1.rds.amazonaws.com --port=5432 --dbname=postgres --username=postgres
Password for user postgres: 
psql (15.6, server 16.1)
WARNING: psql major version 15, server major version 16.
         Some psql features might not work.
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off)
Type "help" for help.

postgres=> 
postgres=> 
postgres=> CREATE TABLE IF NOT EXISTS users ( user_id INTEGER PRIMARY KEY, email_address TEXT, created_at INTEGER, deleted INTEGER, settings TEXT);
CREATE TABLE
postgres=> INSERT INTO users (user_id, email_address, created_at, deleted, settings) VALUES (1, 'maria@example.com', 0, 0, '');
INSERT 0 1
postgres=> INSERT INTO users (user_id, email_address, created_at, deleted, settings) VALUES (999, 'admin@example.com', 0, 0, '');
INSERT 0 1
postgres=> select * from users;
 user_id |   email_address   | created_at | deleted | settings 
---------+-------------------+------------+---------+----------
       1 | maria@example.com |          0 |       0 | 
     999 | admin@example.com |          0 |       0 | 
(2 rows)

postgres=> \q
[ec2-user@ip-172-31-24-240 ~]$
```

```bash
sudo dnf update -y
sudo dnf install postgresql15
psql --host=database-test1.crm86sia6owz.us-east-1.rds.amazonaws.com --port=5432 --dbname=postgres --username=postgres
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
sudo yum install -y gcc
sudo yum install -y git
git clone https://github.com/danny-yamamoto/rust-api-samples-axum.git
cd rust-api-samples-axum/
```
