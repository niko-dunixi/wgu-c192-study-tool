#!/usr/bin/env bash
set -x
./stop.sh
./start.sh && ./psql.sh
