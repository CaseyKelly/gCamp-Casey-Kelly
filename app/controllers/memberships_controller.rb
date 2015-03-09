class MembershipsController < ApplicationController
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
        redirect_to project_memberships_path(@project), notice: 'Membership was successfully created.'
      else
        render :new
     end
   end

   private

   def membership_params
     params.require(:membership).permit(:user_id, :role)
   end
end
