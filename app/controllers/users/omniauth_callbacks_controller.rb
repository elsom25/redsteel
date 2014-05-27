class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  User.omniauth_providers.each do |auth_provider|
    define_method(auth_provider){ finish }
  end

protected

  def finish
    if (authentication = provider.user_authentications.where(uid: auth.uid).first)
      sign_in_with_existing_authentication(authentication)
    else
      create_authentication_and_sign_in
    end
  end

  def provider
    @provider ||= AuthenticationProvider.where(name: auth.provider).first
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end

  def user
    @user ||= current_user ||
              User.where(email: auth['info']['email']).first ||
              User.create_from_omniauth(auth)
  end

  def sign_in_with_existing_authentication(authentication)
    sign_in_and_redirect :user, authentication.user
  end

  def create_authentication_and_sign_in
    if user && user.persisted?
      create_authentication
      scrape
      sign_in_and_redirect :user, user, event: :authentication # this will throw if user is not activated
    else
      redirect_to new_user_session_path, status: 303, alert: user.errors.full_messages.to_sentence
    end
  end

  def create_authentication
    UserAuthentication.create_from_omniauth(auth, user, provider)
  end

  def scrape
    scraper = ("#{provider.name.titleize}DataScraper".constantize rescue nil)
    return unless scraper

    scraper.delay.perform(user, auth)
  end
end
