class WeeklySummaryWorker < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      WeeklySummaryMailer.weekly_summary(user).deliver_now
    end
  end
end