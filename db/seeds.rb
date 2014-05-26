user = CreateAdminService.call
puts 'CREATED ADMIN USER: ' << user.email

AuthenticationProvider.create(name: 'facebook')
AuthenticationProvider.create(name: 'twitter')
