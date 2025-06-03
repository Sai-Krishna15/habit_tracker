class RemoveFrequencyAndTargetDaysFromHabits < ActiveRecord::Migration[7.1]
  def change
    remove_column :habits, :frequency, :string
    remove_column :habits, :target_days, :integer
  end
end
