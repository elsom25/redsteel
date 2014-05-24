class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :recoverable, :trackable, :validatable#, :omniauthable, omniauth_providers: [:facebook, :twitter, :gplus]
  enum role: [:user, :admin] # position 0 is the default

  def name
    given_name || family_name
  end

  def full_name
    "#{given_name} #{family_name}".strip if name.present?
  end
end
