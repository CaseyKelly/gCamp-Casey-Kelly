class MembershipsController < ApplicationController
  before_action :check_membership
  before_action :check_owner, only: [:edit, :update]

  def new
    @membership = Membership.new
  end

  def index
    @project = Project.find(params[:project_id])
    @membership = Membership.new
    @memberships = Membership.all
  end

  def create
    @project = Project.find(params[:project_id])
    @membership = Membership.new(membership_params)
    @membership.project_id = @project.id
    @membership.user_id
      if @membership.save
        redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully added."
      else
        render :index
     end
   end

   def update
     @project = Project.find(params[:project_id])
     @membership = Membership.find(params[:id])
     @membership.update(membership_params)
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully updated."
   end

   def destroy
     @project = Project.find(params[:project_id])
     @membership = Membership.find(params[:id])
     if current_user.last_project_owner?(@project)
       redirect_to project_memberships_path(@project), :alert => 'Projects must have at least one owner.'
     else
       @membership.destroy
        redirect_to projects_path, notice: "#{@membership.user.full_name} was successfully removed."
      end
   end

   private

   def check_membership
     unless current_user.admin?
       @project = Project.find(params[:project_id])
       redirect_to projects_path, :alert => 'You do not have access to that project.' unless @project.users.include? current_user
     end
   end

   def check_owner
     unless current_user.admin?
       redirect_to project_path(@project), alert: 'You do not have access.' unless current_user.project_owner?(@project)
     end
   end

   def membership_params
     params.require(:membership).permit(:user_id, :role)
   end
end
