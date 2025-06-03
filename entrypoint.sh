#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /rails/tmp/pids/server.pid

# Wait for database to be ready
echo "Waiting for database to be ready..."
max_attempts=30
attempt=1
until bundle exec rails db:version > /dev/null 2>&1; do
  if [ $attempt -gt $max_attempts ]; then
    echo "Error: Database not ready after $max_attempts attempts"
    exit 1
  fi
  echo "Database not ready - attempt $attempt of $max_attempts"
  sleep 2
  attempt=$((attempt + 1))
done
echo "Database is ready!"

# Run database migrations
echo "Running database migrations..."
bundle exec rake db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec bundle exec "$@"