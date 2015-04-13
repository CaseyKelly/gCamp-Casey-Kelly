class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project
  before_action :check_membership
  before_action :authenticate

  def index
    @tasks = @project.tasks
  end

  def show
    @comment = Comment.new
    @comments = @task.comments
  end

  def new
    @task = Task.new
    @submit_name = "Create Task"
  end

  def edit
    @submit_name = "Update Task"
  end

  def create
    @task = Task.new(task_params)
    @task.project_id = params[:project_id]
      if @task.save
        redirect_to project_tasks_path(@project), notice: 'Task was successfully created.'
      else
        render :new
      end
  end

  def update
    @task.project_id = params[:project_id]
      if @task.update(task_params)
        redirect_to project_tasks_path(@project), notice: 'Task was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @task.project_id = params[:project_id]
    @task.destroy
      redirect_to project_tasks_url, notice: 'Task was successfully destroyed.'
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def check_membership
      unless current_user.admin?
        redirect_to projects_path, :alert => 'You do not have access to that project.' unless @project.users.include? current_user
      end
    end

    def task_params
      params.require(:task).permit(:description, :due_date, :complete, :project_id)
    end
end
