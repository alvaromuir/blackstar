class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have signed up successfully."
      redirect_to categories_path
    else
      render :new
    end
  end

  def show
    #  see before_action
  end

  def edit
    #  see before_action
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User has been updated."
      redirect_to @user
    else
      flash[:alert] = "User has not been updated."
      render "edit"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The user you are looking for can not be found."
      redirect_to users_path
    end
end
