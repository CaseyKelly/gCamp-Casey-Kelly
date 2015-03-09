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
  end
end
