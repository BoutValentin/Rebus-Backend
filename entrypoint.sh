#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
./bin/rails db:drop
./bin/rails db:create
./bin/rails db:migrate
./bin/rails db:seed
exec "$@"
