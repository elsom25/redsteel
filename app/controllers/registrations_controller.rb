class RegistrationsController < Devise::RegistrationsController
  before_action :update_sanitized_params, if: :devise_controller?

protected

  def update_sanitized_params
    standard_params = %i(given_name family_name email gender street_address city postal_code country_name
                         password password_confirmation)
    devise_parameter_sanitizer.for(:sign_up) << standard_params
    devise_parameter_sanitizer.for(:account_update) << (standard_params << :current_password)
  end
end
