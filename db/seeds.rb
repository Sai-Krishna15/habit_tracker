# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create a test user
user = User.create!(
  email: 'test@example.com',
  password: 'password123',
  password_confirmation: 'password123'
)

# Set a fixed creation date for all habits (2 months ago)
habit_creation_date = 2.months.ago

# Create some test habits
habits = [
  user.habits.create!(
    name: 'Morning Exercise',
    description: '30 minutes of exercise every morning',
    created_at: habit_creation_date,
    updated_at: habit_creation_date
  ),
  user.habits.create!(
    name: 'Read Books',
    description: 'Read for at least 30 minutes',
    created_at: habit_creation_date,
    updated_at: habit_creation_date
  ),
  user.habits.create!(
    name: 'Meditate',
    description: '15 minutes of meditation',
    created_at: habit_creation_date,
    updated_at: habit_creation_date
  )
]

# Add check-ins for the past 30 days with different patterns
habits.each_with_index do |habit, index|
  today = Date.today

  # First habit: Perfect streak for the last 7 days
  if index == 0
    7.times do |i|
      habit.habit_checkins.create!(date: today - i.days)
    end
  end

  # Second habit: Alternating days for the last 14 days
  if index == 1
    7.times do |i|
      habit.habit_checkins.create!(date: today - (i * 2).days)
    end
  end

  # Third habit: Random pattern for the last 30 days
  if index == 2
    15.times do |i|
      # Create check-ins for random days in the past 30 days
      random_day = today - rand(30).days
      habit.habit_checkins.create!(date: random_day) unless habit.habit_checkins.exists?(date: random_day)
    end
  end
end

puts "Created test data:"
puts "- 1 test user (email: test@example.com, password: password123)"
puts "- 3 habits created on #{habit_creation_date.strftime('%B %d, %Y')}"
puts "- Various check-ins for testing streaks and consistency"
