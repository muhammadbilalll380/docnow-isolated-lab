#!/usr/bin/env bash
# Proves the api container cannot reach the internet.
cd "$(dirname "$0")/.."
echo "Trying outbound connection from api container (should FAIL)..."
if docker compose exec -T api python -c "import urllib.request as u; u.urlopen('http://example.com', timeout=5)" 2>/dev/null; then
  echo "NOT isolated!"; exit 1
else
  echo "OK: no outbound traffic from the lab network."
fi
