# == Schema Information
#
# Table name: users
#
#  country_name           :string(255)
#  created_at             :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  family_name            :string(255)
#  gender                 :string(255)
#  given_name             :string(255)
#  id                     :integer          not null, primary key
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  locality               :string(255)
#  postal_code            :string(255)
#  region                 :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  role                   :integer          default(0), not null
#  sign_in_count          :integer          default(0), not null
#  street_address         :string(255)
#  updated_at             :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :recoverable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  enum role: [:user, :admin] # position 0 is the default

protected
  has_many :house_roles
  has_many :house_role_owners, -> { with_all_roles(:owner) }, class_name: HouseRole.name
  has_many :house_role_residents, -> { with_all_roles(:resident) }, class_name: HouseRole.name

public
  has_many :houses, -> { uniq }, through: :house_roles
  has_many :owned_houses, -> { uniq }, through: :house_role_owners, source: :house
  has_many :residences, -> { uniq }, through: :house_role_residents, source: :house

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
