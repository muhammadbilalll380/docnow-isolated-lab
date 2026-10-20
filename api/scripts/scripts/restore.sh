#!/usr/bin/env bash
# Restore the DB from backups/latest.sql (or a file passed as $1)
set -e
cd "$(dirname "$0")/.."
FILE="${1:-backups/latest.sql}"
[ -f "$FILE" ] || { echo "No snapshot found: $FILE"; exit 1; }
docker compose exec -T db psql -U docnow -d postgres -c "DROP DATABASE IF EXISTS docnow;"
docker compose exec -T db psql -U docnow -d postgres -c "CREATE DATABASE docnow;"
docker compose exec -T db psql -U docnow -d docnow < "$FILE"
echo "Restored from $FILE"
