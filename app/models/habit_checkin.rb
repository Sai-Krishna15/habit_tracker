class HabitCheckin < ApplicationRecord
  belongs_to :habit

  validates :date, presence: true
  validates :date, uniqueness: { scope: :habit_id, message: "already checked in for this habit" }
  validate :date_cannot_be_in_future

  private

  def date_cannot_be_in_future
    if date.present? && date > Date.today
      errors.add(:date, "can't be in the future")
    end
  end
end
