# MySQL/MariaDB Performance Test

This experiment compares query performance across MySQL 8.0, MySQL 8.4, and MariaDB 10.11 using WordPress-style data.

## Prerequisites

- Docker and Docker Compose
- MySQL client (`mysql` command)
- Bash

## Setup

1. Start the databases:
   ```bash
   docker-compose up -d
   ```

2. Wait for databases to initialize (~30 seconds)

3. Verify all databases are running:
   ```bash
   docker ps
   ```

## Running the Experiment

1. Populate each database with test data:
   ```bash
   ./populate.sh 8-0 100000
   ./populate.sh 8-4 100000
   ./populate.sh mariadb-10-11 100000
   ```

2. Run the test query on each database:
   ```bash
   ./run_query.sh 8-0
   ./run_query.sh 8-4
   ./run_query.sh mariadb-10-11
   ```

## Database Details

| Database | Port | Version |
|----------|------|---------|
| MySQL 8.0 | 33060 | mysql:8.0 |
| MySQL 8.4 | 33064 | mysql:8.4 |
| MariaDB 10.11 | 33065 | mariadb:10.11 |

## Data Distribution

The populate script creates posts with:
- 60% regular posts
- 15% products
- 10% pages
- 10% attachments
- 5% revisions

Post statuses:
- 90% published
- 5% draft
- 5% trash

## Cleanup

```bash
docker-compose down -v  # -v removes volumes/data
```
