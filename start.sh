#!/usr/bin/env bash
set -e

source environment.vars

# https://www.postgresql.org/docs/9.4/libpq-pgpass.html
pgpass_directory="$(mktemp -d)"
echo "0.0.0.0:5432:${POSTGRES_DB}:${POSTGRES_USER}:${POSTGRES_PASSWORD}" > "${pgpass_directory}/.pgpass"
chmod 0600 "${pgpass_directory}/.pgpass"

container_name=wgu-postgres

docker run \
  --rm -d \
  --name "${container_name}" \
  --env-file environment.vars \
  --env "PGPASSFILE=/pgpass_directory/.pgpass" \
  -v ${pgpass_directory}:/pgpass_directory \
  -v "$(pwd)/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d" \
  postgres:13

function container-exists() {
  docker container list --format '{{.Names}}' | grep "${container_name}" >/dev/null
}

function container-ready() {
  docker exec "${container_name}" pg_isready >/dev/null
}

while container-exists && ! container-ready ; do
  printf '.'
  sleep 0.25s
done
container-exists