# rust-api-samples-axum
Implement Rust API with Axum.

## Local
### Create database
```bash
sudo apt-get update
sudo apt-get install -y postgresql-client

PGPASSWORD=postgres psql -h db -p  5432 -U postgres -d postgres
psql -h db -p  5432 -U postgres -d postgres
```

```sql
CREATE TABLE IF NOT EXISTS users ( user_id INTEGER PRIMARY KEY, email_address TEXT, created_at INTEGER, deleted INTEGER, settings TEXT);
INSERT INTO users (user_id, email_address, created_at, deleted, settings) VALUES (1, 'maria@example.com', 0, 0, '');
INSERT INTO users (user_id, email_address, created_at, deleted, settings) VALUES (999, 'admin@example.com', 0, 0, '');
```

### Set environment variables
```bash
export DB_HOST="db"
export DB_PASSWORD="postgres"
echo $DB_HOST
echo $DB_PASSWORD
```

### Run app
```bash
cargo run
```

```bash:log
@danny-yamamoto ➜ /workspaces/rust-api-samples-axum (feature/add-ec2-to-readme) $ cargo run
   Compiling rust-api-samples-axum v0.1.0 (/workspaces/rust-api-samples-axum)
    Finished dev [unoptimized + debuginfo] target(s) in 14.38s
     Running `target/debug/rust-api-samples-axum`
```

```bash:log
@danny-yamamoto ➜ /workspaces/rust-api-samples-axum (feature/add-ec2-to-readme) $ curl -i localhost:3000
HTTP/1.1 200 OK
content-type: application/json
content-length: 31
date: Fri, 22 Mar 2024 06:27:50 GMT

[{"user_id":1},{"user_id":999}]
@danny-yamamoto ➜ /workspaces/rust-api-samples-axum (feature/add-ec2-to-readme) $
```

## AWS
### SSH
```bash
ssh -i local.pem ec2-user@ec2-x-x-x-x.compute-1.amazonaws.com
```

### Create database
```bash
sudo dnf update -y
sudo dnf install postgresql15

psql --host=database-test1.hogehoge.us-east-1.rds.amazonaws.com --port=5432 --dbname=postgres --username=postgres
```

```bash: log
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

### Deploy app
```bash
touch /workspaces/rust-api-samples-axum/local.pem
chmod 700 /workspaces/rust-api-samples-axum/local.pem
scp -i /workspaces/rust-api-samples-axum/local.pem /workspaces/rust-api-samples-axum/release ec2-user@ec2-x-x-x-x.compute-1.amazonaws.com:/home/ec2-user/release
```

### Set environment variables
```bash
export DB_HOST="xxxx"       # Endpoint
export DB_PASSWORD="zzzz"   # Auto generated password
echo $DB_HOST
echo $DB_PASSWORD
```

### Run app
```bash
[ec2-user@ip-172-31-24-240 ~]$ ./release &
[1] 41692
[ec2-user@ip-172-31-24-240 ~]$ curl -i localhost:3000
HTTP/1.1 200 OK
content-type: application/json
content-length: 31
date: Fri, 22 Mar 2024 06:34:11 GMT

[{"user_id":1},{"user_id":999}]
[ec2-user@ip-172-31-24-240 ~]$ 
```

## AWS SSM
```bash
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
session-manager-plugin
```

```bash
@danny-yamamoto ➜ /workspaces/rust-api-samples-axum (main) $ session-manager-plugin

The Session Manager plugin was installed successfully. Use the AWS CLI to start a session.

@danny-yamamoto ➜ /workspaces/rust-api-samples-axum (main) $
```

```bash
@danny-yamamoto ➜ /workspaces/rust-api-samples-axum (main) $ aws configure
AWS Access Key ID [None]: yyyyy
AWS Secret Access Key [None]: zzzzz
Default region name [None]: us-east-1
Default output format [None]: text
@danny-yamamoto ➜ /workspaces/rust-api-samples-axum (main) $ 
```
https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-chap-authentication.html
https://zenn.dev/mo_ri_regen/articles/aws-cli-setting

```bash
export DEFAULT_REGION="us-east-1"
export ECS_CLUSTER_NAME="arn:aws:ecs:us-east-1:999999999999:cluster/MyAppCluster"
export ECS_SERVICE_NAME="arn:aws:ecs:us-east-1:999999999999:service/MyAppCluster/myapp-service-b"
export ECS_TASK_NAME="arn:aws:ecs:us-east-1:999999999999:task/MyAppCluster/abcdefg"
echo $DEFAULT_REGION
echo $ECS_CLUSTER_NAME
echo $ECS_SERVICE_NAME
echo $ECS_TASK_NAME
aws ecs list-clusters
aws ecs list-tasks --cluster $ECS_CLUSTER_NAME
aws ecs describe-tasks \
    --cluster $ECS_CLUSTER_NAME \
    --tasks $ECS_TASK_NAME
aws ecs update-service --region $DEFAULT_REGION --cluster $ECS_CLUSTER_NAME --service $ECS_SERVICE_NAME --enable-execute-command
```

### Install plugin
- https://docs.aws.amazon.com/ja_jp/systems-manager/latest/userguide/install-plugin-debian-and-ubuntu.html
