module HabitsHelper
  def calendar_day_class(date, checkin, created_at)
    if date > Date.today
      'bg-gray-50' # Future dates
    elsif checkin
      'bg-green-500' # Completed days
    elsif date < Date.today && date >= created_at.to_date
      'bg-red-100' # Missed days
    else
      'bg-gray-100' # Days before habit creation
    end
  end

  def calendar_text_class(date, checkin)
    if date > Date.today
      'text-gray-400' # Future dates
    elsif checkin
      'text-white' # Completed days
    elsif date < Date.today
      'text-red-600' # Missed days
    else
      'text-gray-600' # Today and past days
    end
  end
end
