#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Wait for database to be ready
echo "Waiting for database to be ready..."
until bundle exec rails db:version > /dev/null 2>&1; do
  echo "Database not ready - sleeping"
  sleep 2
done
echo "Database is ready!"

# Run database migrations
echo "Running database migrations..."
bundle exec rake db:migrate

# Clean up any existing assets
echo "Cleaning up existing assets..."
rm -rf public/assets

# Precompile assets
echo "Precompiling assets..."
export SECRET_KEY_BASE_DUMMY=1
bundle exec rake assets:precompile
bundle exec rake assets:clean

echo "Build completed successfully!"