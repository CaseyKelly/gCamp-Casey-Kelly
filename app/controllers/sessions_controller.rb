class SessionsController < ApplicationController
  after_filter "save_my_previous_url", only: [:new]

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to session[:my_previous_url], notice: 'Welcome back, stranger!'
    else
      flash[:login_alert] = "Username / password combination is invalid"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path, notice: "We're sorry to see you go!"
  end

  private

  def save_my_previous_url
    if request.referer.present?
      session[:my_previous_url] = URI(request.referer).path
    else
      session[:my_previous_url] = new_project_path
    end
  end

end
