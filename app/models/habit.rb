class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_checkins, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, length: { maximum: 500 }

  def current_streak
    streak = 0
    current_date = Date.today

    while habit_checkins.exists?(date: current_date)
      streak += 1
      current_date -= 1.day
    end

    streak
  end

  def longest_streak
    return 0 if habit_checkins.empty?

    dates = habit_checkins.pluck(:date).sort
    current_streak = 1
    longest_streak = 1

    (1...dates.length).each do |i|
      if dates[i] == dates[i-1] + 1.day
        current_streak += 1
        longest_streak = [longest_streak, current_streak].max
      else
        current_streak = 1
      end
    end

    longest_streak
  end

  def consistency_percentage
    return 0 if habit_checkins.empty?

    # Calculate total days since habit creation (including today)
    total_days = (Date.today - created_at.to_date).to_i + 1

    # Get the count of days where the habit was completed
    completed_days = habit_checkins.count

    # Calculate percentage: (completed days / total days) * 100
    # Round to 1 decimal place for cleaner display
    ((completed_days.to_f / total_days) * 100).round(1)
  end

  def checkins_for_month(year, month)
    start_date = Date.new(year, month, 1)
    end_date = start_date.end_of_month
    habit_checkins.where(date: start_date..end_date)
  end
end
