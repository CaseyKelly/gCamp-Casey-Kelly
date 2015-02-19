class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to users_path, notice: 'Welcome back, stranger!'
    else
      redirect_to signup_path, alert: "Username / password combination is invalid"
    end
  end

  def destroy
    session.clear
    redirect_to root_path, notice: "We're sorry to see you go!"
  end
end
