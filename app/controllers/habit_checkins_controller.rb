class HabitCheckinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit

  def create
    @checkin = @habit.habit_checkins.create!(date: Date.today)
    @month = Date.today.beginning_of_month

    respond_to do |format|
      format.html { redirect_to @habit, notice: 'Habit marked as complete.' }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "habit_#{@habit.id}",
          partial: 'habits/habit',
          locals: { habit: @habit, current_month: @month }
        )
      end
    end
  end

  def destroy
    @checkin = @habit.habit_checkins.find_by!(date: Date.today)
    @checkin.destroy
    @month = Date.today.beginning_of_month

    respond_to do |format|
      format.html { redirect_to @habit, notice: 'Habit marked as incomplete.' }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "habit_#{@habit.id}",
          partial: 'habits/habit',
          locals: { habit: @habit, current_month: @month }
        )
      end
    end
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
  end
end
