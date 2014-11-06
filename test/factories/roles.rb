FactoryGirl.define do
  factory :role do
    house
    user
    roles [:resident]
  end
end
