class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks
    render json: @tasks
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      render json: @task
    else
      render json: { success: false }
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :due_date)
  end
end
