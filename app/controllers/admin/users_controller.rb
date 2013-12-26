class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order(:email)
  end

  def new
    @user = User.new
  end

  def create
    params = user_params.dup
    params[:password_confirmation] = params[:password]
    @user = User.new(params)
    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User has not been created."
      render :action => "new"
    end 
  end

  def show
    # before_action
  end

  def edit
     # before_action
  end

  def update
    # before_action
    if params[:user][:password].blank?
      # clear form
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    if @user.update(user_params)
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been updated."
      render action: "edit"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name,
                                    :email,
                                    :password,
                                    :password_confirmation,
                                    :admin)
    end
    def set_user
      @user = User.find(params[:id])
    end
end
