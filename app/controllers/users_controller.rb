class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, except: [:show]

  def index
    @users = policy_scope(User)
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin? || @user == current_user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

protected

  def secure_params
    params.require(:user).permit(:role)
  end

end
