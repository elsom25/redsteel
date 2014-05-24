FactoryGirl.define do
  factory :user, class: 'User' do
    email    'test@email.com'
    password 'bad_password'
    password_confirmation 'bad_password'

    factory :named_user do
      first_name 'Bob'
      last_name  'Hippo'
    end

    factory :admin_user do
      role :admin

      factory :named_admin_user do
        first_name 'Admin'
        last_name  'Hippo'
      end
    end
  end
end
