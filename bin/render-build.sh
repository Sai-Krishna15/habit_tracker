#!/usr/bin/env bash
# exit on error
set -o errexit
set -o pipefail
set -o nounset

echo "Starting build process..."

# Install dependencies
echo "Installing dependencies..."
bundle install

# Clean up any existing assets
echo "Cleaning up existing assets..."
rm -rf public/assets

# Precompile assets
echo "Precompiling assets..."
export SECRET_KEY_BASE_DUMMY=1
export RAILS_ENV=production
export RAILS_SERVE_STATIC_FILES=true

if [ -z "${RAILS_MASTER_KEY:-}" ]; then
  echo "Error: RAILS_MASTER_KEY is not set"
  exit 1
fi

bundle exec rake assets:clobber
bundle exec rake assets:precompile
bundle exec rake assets:clean

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

# Create database if it doesn't exist
echo "Creating database if it doesn't exist..."
bundle exec rails db:create || true

# Run database migrations
echo "Running database migrations..."
bundle exec rake db:migrate

echo "Build completed successfully!"