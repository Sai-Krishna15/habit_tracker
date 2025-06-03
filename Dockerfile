# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    PATH="/usr/local/bundle/bin:$PATH"

# Install packages needed to build gems and node modules
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential curl libpq-dev node-gyp pkg-config python-is-python3

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Install application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile --gemfile app/ lib/

# Precompiling assets for production
ARG RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 RAILS_MASTER_KEY=${RAILS_MASTER_KEY} bundle exec rake assets:precompile

# Final stage for app image
FROM base

# Install packages needed for deployment
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libsqlite3-0 && \
    rm -rf /var/lib/apt/lists /usr/share/doc /usr/share/man

# Set environment variables
ENV RAILS_ENV=production \
    RAILS_MASTER_KEY=${RAILS_MASTER_KEY} \
    RAILS_SERVE_STATIC_FILES=true \
    PATH="/usr/local/bundle/bin:$PATH"

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 8080
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
