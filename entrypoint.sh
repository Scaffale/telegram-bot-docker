#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /rambot/tmp/pids/server.pid

rails db:create
rails db:migrate
rails file_adder:full
rails link_webhook

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
