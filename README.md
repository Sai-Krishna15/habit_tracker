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
