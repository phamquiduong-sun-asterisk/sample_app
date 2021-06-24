class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :load_user, only: [:show, :update, :edit, :correct_user]

  def destroy
    user = User&.find_by(id: params[:id])
    return unless current_user.admin? && !current_user?(user)

    if user&.destroy
      flash[:success] = t "user_deleted"
    else
      flash[:danger] = t "delete_fail"
    end
    redirect_to users_url
  end

  def index
    @users = User.created_at_desc.paginate(page: params[:page], per_page: Settings.users.per_page)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "welcome_to_the_sample_app"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    return if @user

    flash[:warning] = t "user_not_found"
    redirect_to root_url
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def load_user
    @user = User&.find_by(id: params[:id])
  end
end
