# == Schema Information
#
# Table name: houses
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  name       :string(255)
#  token      :string(255)      not null
#  updated_at :datetime
#
# Indexes
#
#  index_houses_on_token  (token) UNIQUE
#

FactoryGirl.define do
  factory :house do
    name "Jesse's House"
  end
end
