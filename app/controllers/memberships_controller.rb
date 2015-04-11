class MembershipsController < ApplicationController
  before_action :check_membership
  before_action :check_owner, only: [:edit, :update, :destroy]

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
     @membership.destroy
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully deleted."
   end

   private

   def check_membership
     @project = Project.find(params[:project_id])
     redirect_to projects_path, :alert => 'You do not have access to that project.' unless @project.users.include? current_user
   end

   def check_owner
     redirect_to project_path(@project), alert: 'You do not have access.' unless current_user.project_owner?(@project)
   end

   def membership_params
     params.require(:membership).permit(:user_id, :role)
   end
end
