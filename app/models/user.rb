class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :recoverable, :trackable, :validatable
  #       :omniauthable, omniauth_providers: [:facebook, :twitter, :gplus]
  enum role: [:user, :admin] # position 0 is the default

  MASCULINE = 'Masculine'.freeze
  FEMININE  = 'Feminine'.freeze
  OTHER     = 'Other'.freeze

  class << self
    def gender_options
      [MASCULINE, FEMININE, OTHER]
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

  def update_address!(address)
    self.locality = address.locality
    self.postal_code = address.postal_code
    self.country_name = address.country_name
    self.save!
  end

  def to_s
    full_name || email
  end
end
