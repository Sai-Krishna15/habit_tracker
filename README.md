# Habit Tracker

A Rails-based habit tracking application that helps users build and maintain positive habits through daily check-ins and weekly progress summaries.

## Features

- User authentication and authorization using Devise
- Create, edit, and delete habits
- Daily habit check-ins
- Calendar view for habit tracking
- Weekly email summaries of habit progress
- Modern UI with Tailwind CSS
- Background job processing with Sidekiq
- Email delivery using ActionMailer

## Prerequisites

- Ruby 3.2.2
- Rails 7.1.3
- PostgreSQL
- Redis (for Sidekiq)

## Setup

1. Clone the repository:

```bash
git clone <repository-url>
cd habit_tracker
```

2. Install dependencies:

```bash
bundle install
```

3. Set up the database:

```bash
rails db:create
rails db:migrate
```

4. Start Redis server (required for Sidekiq):

```bash
redis-server
```

5. Start Sidekiq in a separate terminal:

```bash
bundle exec sidekiq
```

6. Start the Rails server:

```bash
rails server
```

7. Visit `http://localhost:3000` in your browser

## Development

### Email Preview

In development, emails are intercepted and can be viewed in the browser:

- Visit `http://localhost:3000/letter_opener` to view sent emails
- Emails are stored in `tmp/letter_opener`

### Running Tests

```bash
rspec
```

## Production Deployment

### Render.com Deployment

1. Create a Render account at https://render.com

2. Connect your GitHub repository to Render

3. In the Render dashboard:

   - Click "New +"
   - Select "Web Service"
   - Choose your repository
   - Configure the service:
     - Name: habit-tracker
     - Environment: Ruby
     - Build Command: `./bin/render-build.sh`
     - Start Command: `bundle exec puma -C config/puma.rb`
   - Add the following environment variables:
     - `RAILS_MASTER_KEY` (from config/master.key)
     - `SMTP_USERNAME` (your SMTP username)
     - `SMTP_PASSWORD` (your SMTP password)
     - `RAILS_ENV` = production
     - `RAILS_SERVE_STATIC_FILES` = true

4. Create a PostgreSQL database:

   - Click "New +"
   - Select "PostgreSQL"
   - Choose the free plan
   - Name it "habit-tracker-db"

5. Create a Redis instance:

   - Click "New +"
   - Select "Redis"
   - Choose the free plan
   - Name it "habit-tracker-redis"

6. Deploy your application:

   - Render will automatically deploy when you push to your main branch
   - You can also manually deploy from the Render dashboard

7. Monitor your application:
   - Use the Render dashboard to view logs
   - Check the "Events" tab for deployment status

### Fly.io Deployment

1. Install the Fly CLI:

```bash
curl -L https://fly.io/install.sh | sh
```

2. Sign up and login to Fly:

```bash
fly auth signup  # If you don't have an account
fly auth login   # If you already have an account
```

3. Launch your app:

```bash
fly launch
```

4. Set up your database:

```bash
fly postgres create
fly postgres attach <your-database-name>
```

5. Set up Redis:

```bash
fly redis create
fly redis attach <your-redis-name>
```

6. Set your secrets:

```bash
fly secrets set RAILS_MASTER_KEY=$(cat config/master.key)
fly secrets set SMTP_USERNAME=your-smtp-username
fly secrets set SMTP_PASSWORD=your-smtp-password
```

7. Deploy your application:

```bash
fly deploy
```

8. Open your application:

```bash
fly open
```

9. Monitor your application:

```bash
fly logs
```

### Heroku Deployment

1. Install the Heroku CLI:

```bash
curl https://cli-assets.heroku.com/install.sh | sh
```

2. Login to Heroku:

```bash
heroku login
```

3. Create a new Heroku app:

```bash
heroku create your-app-name
```

4. Add PostgreSQL addon:

```bash
heroku addons:create heroku-postgresql:mini
```

5. Add Redis addon:

```bash
heroku addons:create heroku-redis:mini
```

6. Configure environment variables:

```bash
heroku config:set RAILS_MASTER_KEY=$(cat config/master.key)
heroku config:set SMTP_USERNAME=your-smtp-username
heroku config:set SMTP_PASSWORD=your-smtp-password
```

7. Deploy your application:

```bash
git push heroku main
```

8. Run database migrations:

```bash
heroku run rails db:migrate
```

9. Open your application:

```bash
heroku open
```

10. Monitor your application:

```bash
heroku logs --tail
```

### Other Deployment Options

For production deployment, configure the following:

1. Set up SMTP settings in `config/environments/production.rb`:

```ruby
config.action_mailer.smtp_settings = {
  address: 'your-smtp-server',
  port: 587,
  domain: 'your-domain.com',
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD'],
  authentication: 'plain',
  enable_starttls_auto: true
}
```

2. Configure environment variables:

- `SMTP_USERNAME`
- `SMTP_PASSWORD`
- `REDIS_URL`
- `SECRET_KEY_BASE`

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
