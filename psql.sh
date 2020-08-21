#!/usr/bin/env bash
set -e

source environment.vars
docker exec -it \
  --env "PGPASSFILE=/pgpass_directory/.pgpass" \
  wgu-postgres psql -U "${POSTGRES_USER}" "${POSTGRES_DB}"
