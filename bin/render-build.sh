#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Clean up any existing assets
rm -rf public/assets

# Precompile assets
export SECRET_KEY_BASE_DUMMY=1
bundle exec rake assets:precompile
bundle exec rake assets:clean

# Run database migrations
bundle exec rake db:migrate