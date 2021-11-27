#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /rambot/tmp/pids/server.pid

RAILS_ENV=development rails db:create
RAILS_ENV=development rails db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
