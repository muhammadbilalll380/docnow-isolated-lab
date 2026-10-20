# DocNow Isolated API Lab

Docker Compose lab running a mock DocNow API, a mock PostgreSQL database and an
nginx reverse proxy. Use it only for testing inside this lab or on systems you
have explicit permission to test.

## Architecture
- `lab_internal` network is `internal: true`, so there is no outbound internet traffic.
- `db` and `api` live only on `lab_internal` (no published ports).
- `proxy` (nginx) joins `lab_internal` and `edge` and is the only service that
  publishes a port (`8080`), forwarding to the API.

## Requirements
Docker and Docker Compose v2.

## Start
    docker compose up -d --build
    curl http://localhost:8080/health
    curl http://localhost:8080/documents

## Stop
    docker compose down

## Reset (fresh containers)
    bash scripts/reset.sh
To wipe data fully: `docker compose down -v` (re-seeds from `db/init.sql`).

## Snapshot / restore
    bash scripts/snapshot.sh
    bash scripts/restore.sh
    bash scripts/restore.sh backups/snapshot_X.sql

## Verify isolation
    bash scripts/verify-isolation.sh

## Limitations
Mock data only, no TLS, passwords are lab-only placeholders.
