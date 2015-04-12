class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  class Unauthorized < StandardError; end

  rescue_from Unauthorized, with: :unauthorized

  def current_user
    User.find_by_id(session[:user_id])
  end
  helper_method :current_user

  def ownership
    if @user.owner == true
      "Owner"
    else
      "Member"
    end
  end
  helper_method :ownership

  def navbar_projects
    Project.all
  end
  helper_method :navbar_projects

  private

  def authenticate
    redirect_to login_path, :alert => 'You must be logged in to visit that page.' unless current_user
  end

  def unauthorized
    render "/users/404.html.erb", status: 404
  end

end
