#!/bin/bash

VERSION=$1
DB_HOST=127.0.0.1

# Set port based on version
case $VERSION in
"8-0")
  DB_PORT=33060
  DB_TYPE="MySQL 8.0"
  ;;
"8-4")
  DB_PORT=33064
  DB_TYPE="MySQL 8.4"
  ;;
"mariadb-10-11")
  DB_PORT=33065
  DB_TYPE="MariaDB 10.11"
  ;;
"mariadb-11-4")
  DB_PORT=33066
  DB_TYPE="MariaDB 11.4"
  ;;
*)
  echo "Error: Unknown version '$VERSION'"
  echo "Valid options: 8-0, 8-4, mariadb-10-11, maraidb-11-4"
  exit 1
  ;;
esac

DB_USER=root
DB_PASS=rootpass
DB_NAME=wordpress

QUERY="EXPLAIN SELECT COUNT(1) FROM wp_posts WHERE post_type = 'post' AND post_status NOT IN ('trash','auto-draft','inherit','request-pending','request-confirmed','request-failed','request-completed') AND post_author = 1;"

echo "Running on $DB_TYPE (port $DB_PORT):"
mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASS $DB_NAME -e "SELECT VERSION();"
mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASS $DB_NAME -e "$QUERY"
