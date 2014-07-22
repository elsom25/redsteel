class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :recoverable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  enum role: [:user, :admin] # position 0 is the default
  rolify

  MASCULINE = 'Masculine'.freeze
  FEMININE  = 'Feminine'.freeze
  OTHER     = 'Other'.freeze

  class << self
    def gender_options
      [MASCULINE, FEMININE, OTHER]
    end

    def create_from_omniauth(data)
      create(
           email: data['info']['email'],
        password: Devise.friendly_token
      )
    end

    def houses(user)
      House.with_any_role([{ name: :owner, resource: user }, { name: :resident, resource: user }])
    end

    def owned_houses(user)
      House.with_role(:owner, user)
    end

    def residences(user)
      House.with_role(:resident, user)
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

  def houses
    self.class.houses(self)
  end

  def owned_houses
    self.class.owned_houses(self)
  end

  def residences
    self.class.residences(self)
  end

  def to_s
    full_name || email
  end
end
