# == Schema Information
#
# Table name: authentication_providers
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime         not null
#
# Indexes
#
#  index_name_on_authentication_providers  (name)
#

class AuthenticationProvider < ActiveRecord::Base
  has_many :users
  has_many :user_authentications

  def to_s
    name
  end
end
