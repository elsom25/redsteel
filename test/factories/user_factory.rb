FactoryGirl.define do
  factory :user, class: 'User' do
    email    'test@email.com'
    password 'bad_password'
    password_confirmation 'bad_password'

    factory :named_user do
      name     'Bob Hippo'
    end

    factory :admin_user do
      name 'Admin Hippo'
      role :admin
    end
  end
end
