class ApplicationController < ActionController::Base
  include Pundit # authorization
  protect_from_forgery with: :exception

  # Verify that controller actions are authorized.
  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

protected

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end
