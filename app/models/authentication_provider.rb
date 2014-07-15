class AuthenticationProvider < ActiveRecord::Base
  has_many :users
  has_many :user_authentications

  def to_s
    name
  end
end
