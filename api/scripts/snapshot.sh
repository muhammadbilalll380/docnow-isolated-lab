#!/usr/bin/env bash
# Save the current database state to backups/
set -e
cd "$(dirname "$0")/.."
mkdir -p backups
FILE="backups/snapshot_$(date +%Y%m%d_%H%M%S).sql"
docker compose exec -T db pg_dump -U docnow docnow > "$FILE"
cp "$FILE" backups/latest.sql
echo "Snapshot saved: $FILE"
