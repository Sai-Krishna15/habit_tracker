class AddFrequencyAndTargetDaysToHabits < ActiveRecord::Migration[7.1]
  def change
    add_column :habits, :frequency, :string
    add_column :habits, :target_days, :integer
  end
end
