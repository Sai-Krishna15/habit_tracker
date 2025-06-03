require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }

  config.on(:startup) do
    Sidekiq.schedule = {
      'weekly_email_summary' => {
        'cron' => '0 9 * * 1', # Every Monday at 9 AM
        'class' => 'WeeklyEmailWorker'
      }
    }
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
end