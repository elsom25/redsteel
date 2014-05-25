class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  User.omniauth_providers.each do |provider|
    define_method(provider){ finish(provider.to_s) }
  end

protected

  def finish(kind)
    if current_user && (r = social_link)
      return r
    end

    login_user(kind)
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end

  def social_link
    id, typ = session[:start_social_link].to_s.split(':', 2)
    session[:start_social_link] = nil

    resource = typ.constantize.find_by_id(id)

    if existing_omniauth
      redirect_to [:edit, resource], status: 303, alert: 'Account already linked elsewhere.'
    else
      resource.linked_omniauths << build_omniauth
      resource.save!
      scrape(resource)
      redirect_to [:edit, resource], status: 303
    end
  end

  def existing_omniauth
    LinkedOmniauth.where(provider: auth.provider, uid: auth.uid).exists?
  end

  def build_omniauth
    LinkedOmniauth.new(
      provider: auth.provider,
      uid: auth.uid,
      data: auth
    )
  end

  def login_user(kind)
    @user = User.find_or_create_by_omniauth(auth)

    if @user && @user.persisted?
      scrape(@user)
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => kind) if is_navigational_format?
    else
      redirect_to new_user_session_path, status: 303, alert: @user.errors.full_messages.to_sentence
    end
  end

  def scrape(user)
    # if user.is_a?(User) && scraper = ("#{auth.provider.titleize}DataScraper".constantize rescue nil)
    #   scraper.delay.perform(user, auth)
    # end
  end
end
