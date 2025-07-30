#!/bin/bash
# Usage: ./run_query_all.sh
# Runs the query on all configured databases

VERSIONS=("8-0" "8-4" "mariadb-10-11" "mariadb-11-4")

for VERSION in "${VERSIONS[@]}"; do
  echo "========================================="
  ./run_query.sh "$VERSION"
  echo
done
