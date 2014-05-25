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
