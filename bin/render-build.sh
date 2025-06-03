#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Clean up any existing assets
echo "Cleaning up existing assets..."
rm -rf public/assets

# Precompile assets
echo "Precompiling assets..."
export SECRET_KEY_BASE_DUMMY=1
export RAILS_ENV=production
export RAILS_SERVE_STATIC_FILES=true
bundle exec rake assets:clobber
bundle exec rake assets:precompile
bundle exec rake assets:clean

# Wait for database to be ready
echo "Waiting for database to be ready..."
until bundle exec rails db:version > /dev/null 2>&1; do
  echo "Database not ready - sleeping"
  sleep 2
done
echo "Database is ready!"

# Create database if it doesn't exist
echo "Creating database if it doesn't exist..."
bundle exec rails db:create

# Run database migrations
echo "Running database migrations..."
bundle exec rake db:migrate

echo "Build completed successfully!"