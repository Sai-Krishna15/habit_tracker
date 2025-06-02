class CreateHabitCheckins < ActiveRecord::Migration[7.1]
  def change
    create_table :habit_checkins do |t|
      t.date :date
      t.references :habit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
