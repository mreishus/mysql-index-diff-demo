#!/bin/bash

VERSION=$1
NUM_POSTS=$2
DB_HOST=127.0.0.1

# Set port based on version
case $VERSION in
"8-0")
  DB_PORT=33060
  ;;
"8-4")
  DB_PORT=33064
  ;;
"9-4")
  DB_PORT=33070
  ;;
"mariadb-10-11")
  DB_PORT=33065
  ;;
"mariadb-11-4")
  DB_PORT=33066
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

echo "Populating $VERSION database on port $DB_PORT with $NUM_POSTS posts..."
echo mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASS $DB_NAME

# Generate insert statements (batch for efficiency)
for i in $(seq 1 $NUM_POSTS); do
  AUTHOR=$((i % 2 + 1)) # Alternate between author 1 and 2
  STATUS=$([ $((i % 1000)) -lt 900 ] && echo 'publish' || ([ $((i % 1000)) -lt 950 ] && echo 'draft' || echo 'trash'))

  if [ $((i % 100)) -lt 60 ]; then
    POST_TYPE="post"
  elif [ $((i % 100)) -lt 75 ]; then
    POST_TYPE="product"
  elif [ $((i % 100)) -lt 85 ]; then
    POST_TYPE="page"
  elif [ $((i % 100)) -lt 95 ]; then
    POST_TYPE="attachment"
  else
    POST_TYPE="revision"
  fi

  echo "INSERT INTO wp_posts (post_author, post_type, post_status, post_title, post_content, post_excerpt) VALUES ($AUTHOR, '$POST_TYPE', '$STATUS', 'Post $i', 'Content $i', 'Content $i');"
done | mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASS $DB_NAME
