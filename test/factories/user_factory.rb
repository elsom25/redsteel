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

FactoryGirl.define do
  factory :user do
    email    'test@email.com'
    password 'bad_password'
    password_confirmation 'bad_password'

    factory :named_user do
      given_name  'Bob'
      family_name 'Hippo'
    end

    factory :admin_user do
      role :admin

      factory :named_admin_user do
        given_name  'Admin'
        family_name 'Hippo'
      end
    end
  end
end
