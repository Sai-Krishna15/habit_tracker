class WeeklySummaryMailer < ApplicationMailer
  def weekly_summary(user)
    @user = user
    @habits = user.habits
    @start_date = 1.week.ago.beginning_of_week
    @end_date = 1.week.ago.end_of_week

    mail(
      to: @user.email,
      subject: "Your Weekly Habit Summary (#{@start_date.strftime('%b %d')} - #{@end_date.strftime('%b %d')})"
    )
  end
end