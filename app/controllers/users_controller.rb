class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:create]
  before_action :set_collaborators, only: [:index, :show]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
    @submit_name = "Create User"
  end

  def edit
    unless current_user.admin?
      if current_user != @user
        raise Unauthorized
      end
    end
    @submit_name = "Update User"
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_project_path, notice: "Thanks for signing up, dude!"
    else
      render :new
    end
  end

  def update
      if @user.update(user_params)
        redirect_to users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @user.destroy
      redirect_to users_url, notice: 'User was successfully deleted.'
  end

private

    def set_user
      @user = User.find(params[:id])
    end
    
    def set_collaborators
      @collaborators = current_user.projects.flat_map{|project| project.users}
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
    end
end
