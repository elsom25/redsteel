class HouseRole < ActiveRecord::Base
  acts_as_roleable roles: [:resident, :owner] # position 0 is the default

  belongs_to :user
  belongs_to :house
end
