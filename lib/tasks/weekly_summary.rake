namespace :weekly_summary do
  desc "Send weekly habit summaries to all users"
  task send: :environment do
    WeeklySummaryWorker.perform_now
  end
end