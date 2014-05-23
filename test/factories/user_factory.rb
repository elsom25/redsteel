FactoryGirl.define do
  factory :user, class: 'User' do
                   name 'Bob Hippo'
                  email 'test@email.com'
               password 'bad_password'
  password_confirmation 'bad_password'
  end

  factory :admin_user do
                   name 'Admin Hippo'
                  email 'admin@email.com'
               password 'bad_password'
  password_confirmation 'bad_password'
                   role :admin
  end
end
