# == Schema Information
#
# Table name: house_roles
#
#  created_at :datetime
#  house_id   :integer          not null
#  id         :integer          not null, primary key
#  roles_mask :integer          default(1), not null
#  updated_at :datetime
#  user_id    :integer          not null
#
# Indexes
#
#  index_house_roles_on_house_id              (house_id)
#  index_house_roles_on_house_id_and_user_id  (house_id,user_id)
#

class HouseRole < ActiveRecord::Base
  extend ActsAsRoleable::Roleatize
  acts_as_roleable roles: [:resident, :owner] # position 0 is the default

  belongs_to :user
  belongs_to :house
end
