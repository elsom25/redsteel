class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  before_action :find_user, only: [:show, :update, :destroy]

  def index
    @users = policy_scope(User)
    authorize @users
  end

  def show
  end

  def update
    if @user.update_attributes(secure_params)
      redirect_to users_path, notice: 'User updated.'
    else
      redirect_to users_path, alert: 'Unable to update user.'
    end
  end

  def destroy
    if @user != current_user
      @user.destroy
      redirect_to users_path, notice: 'User deleted.'
    else
      redirect_to users_path, notice: "Can't delete yourself."
    end
  end

protected

  def find_user
    @user = User.find params[:id]
    authorize @user
  end

  def secure_params
    params.require(:user).permit(:role)
  end
end
