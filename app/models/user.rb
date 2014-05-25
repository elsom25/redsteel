class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :recoverable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]
  has_many :linked_omniauths
  enum role: [:user, :admin] # position 0 is the default

  MASCULINE = 'Masculine'.freeze
  FEMININE  = 'Feminine'.freeze
  OTHER     = 'Other'.freeze

  class << self
    def gender_options
      [MASCULINE, FEMININE, OTHER]
    end

    def find_or_create_by_omniauth(auth, extra={})
      user = LinkedOmniauth.where(provider: auth.provider, uid: auth.uid).first.try(:owner) ||
        User.create(extra.merge(linked_omniauths: [LinkedOmniauth.new(provider: auth.provider, uid: auth.uid, data: auth)]))

      if user && !user.is_a?(User)
        User.new.tap{ |u| u.errors.add(:account, 'already linked elsewhere.') }
      else
        user
      end
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
