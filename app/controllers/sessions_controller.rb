class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Welcome back, stranger!'
    else
      @user.errors[:base] << "Invalid email / password"
      render :login
    end
  end
  def destroy
    session.clear
    redirect_to root_path, notice: "We're sorry to see you go!"
  end
end
