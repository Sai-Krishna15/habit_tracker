class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: [:show, :edit, :update, :destroy, :confirm_delete]

  def index
    @habits = current_user.habits.order(created_at: :desc)
    @month = if params[:month] && params[:year]
      Date.new(params[:year].to_i, params[:month].to_i, 1)
    else
      Date.today.beginning_of_month
    end

    respond_to do |format|
      format.html
      format.turbo_stream do
        if params[:month] && params[:year]
          render turbo_stream: turbo_stream.replace(
            "calendar_#{params[:habit_id]}",
            partial: "habits/calendar",
            locals: { habit: Habit.find(params[:habit_id]), current_month: @month }
          )
        end
      end
    end
  end

  def show
    @month = if params[:month] && params[:year]
      Date.new(params[:year].to_i, params[:month].to_i, 1)
    else
      Date.today.beginning_of_month
    end

    respond_to do |format|
      format.html
      format.turbo_stream do
        if params[:month] && params[:year]
          render turbo_stream: turbo_stream.replace(
            "calendar_#{@habit.id}",
            partial: "habits/calendar",
            locals: { habit: @habit, current_month: @month }
          )
        else
          render turbo_stream: turbo_stream.replace(
            "habit_#{@habit.id}",
            partial: "habits/habit",
            locals: { habit: @habit, current_month: @month }
          )
        end
      end
    end
  end

  def new
    @habit = current_user.habits.build
  end

  def create
    @habit = current_user.habits.build(habit_params)

    if @habit.save
      redirect_to habits_path, notice: "Habit was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @habit.update(habit_params)
      redirect_to habits_path, notice: "Habit was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def confirm_delete
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def cancel_delete
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("delete_modal", "")
      end
    end
  end

  def destroy
    @habit.destroy
    respond_to do |format|
      format.html { redirect_to habits_path, notice: "Habit was successfully deleted." }
      format.turbo_stream {
        if current_user.habits.empty?
          render turbo_stream: [
            turbo_stream.remove(@habit),
            turbo_stream.update("delete_modal", ""),
            turbo_stream.update("habits_list", partial: "habits/empty_state")
          ]
        else
          render turbo_stream: [
            turbo_stream.remove(@habit),
            turbo_stream.update("delete_modal", "")
          ]
        end
      }
    end
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:name, :description, :frequency, :reminder_time)
  end
end
