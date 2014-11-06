# == Schema Information
#
# Table name: user_authentications
#
#  authentication_provider_id :integer
#  created_at                 :datetime         not null
#  data                       :text
#  id                         :integer          not null, primary key
#  token                      :string(255)
#  token_expires_at           :datetime
#  uid                        :string(255)
#  updated_at                 :datetime         not null
#  user_id                    :integer
#
# Indexes
#
#  index_user_authentications_on_authentication_provider_id  (authentication_provider_id)
#  index_user_authentications_on_user_id                     (user_id)
#

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
