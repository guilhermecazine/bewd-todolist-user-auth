# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = current_user.tasks
    render json: { tasks: @tasks.as_json(only: [:id, :content, :completed, :created_at, :updated_at]) }
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      render json: { task: @task.as_json(only: [:id, :content, :completed, :created_at, :updated_at]) }, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index_by_current_user
    @tasks = current_user.tasks
    render json: { tasks: @tasks.as_json(only: [:id, :content, :completed, :created_at, :updated_at]) }
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    if @task.destroy
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  def mark_complete
    @task = current_user.tasks.find(params[:id])
    if @task.update(completed: true)
      render json: { task: @task.as_json(only: [:id, :content, :completed, :created_at, :updated_at]) }
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def mark_active
    @task = current_user.tasks.find(params[:id])
    if @task.update(completed: false)
      render json: { task: @task.as_json(only: [:id, :content, :completed, :created_at, :updated_at]) }
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:content, :completed)
  end

  def authenticate_user!
    token = cookies.signed[:todolist_session_token]
    session = Session.find_by(token: token)
    if session.nil?
      render json: { success: false }, status: :unauthorized
    else
      @current_user = session.user
    end
  end

  def current_user
    @current_user
  end
end
