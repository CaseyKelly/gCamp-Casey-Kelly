class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
    @submit_name = 'Create Project'
  end

  def edit
    @submit_name = "Update Project"
  end

  def create
    @project = Project.new(project_params)
      if @project.save
        @project.memberships.create(role: 1, user_id: current_user.id)
        redirect_to project_tasks_path(@project), notice: 'Project was successfully created.'
      else
        render :new
      end
  end

  def update
      if @project.update(project_params)
        redirect_to @project, notice: 'Project was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @project.destroy
      redirect_to projects_url, notice: 'Project was successfully deleted.'
  end

  private

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name)
    end

end
