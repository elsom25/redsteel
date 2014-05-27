class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :recoverable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  enum role: [:user, :admin] # position 0 is the default

  MASCULINE = 'Masculine'.freeze
  FEMININE  = 'Feminine'.freeze
  OTHER     = 'Other'.freeze

  class << self
    def gender_options
      [MASCULINE, FEMININE, OTHER]
    end

    def create_from_omniauth(data)
      attributes = {
           email: data['info']['email'],
        password: Devise.friendly_token
      }
      create(attributes)
    end
  end

  def name
    given_name || family_name
  end

  def full_name
    "#{given_name} #{family_name}".strip if name.present?
  end

  def full_address
    address_array = [street_address, locality, postal_code, country_name].compact
    address_array.join(', ') if address_array.present?
  end

  def to_s
    full_name || email
  end
end
