class UserAuthentication < ActiveRecord::Base
  belongs_to :user
  belongs_to :authentication_provider

  serialize :data

  class << self
    def create_from_omniauth(data, user, provider)
      expires_at = data['credentials']['expires_at']
      token_expires_at = Time.at(expires_at).to_datetime if expires_at
      create(
                           user: user,
        authentication_provider: provider,
                            uid: data['uid'],
                          token: data['credentials']['token'],
               token_expires_at: token_expires_at,
                           data: data
      )
    end
  end
end
