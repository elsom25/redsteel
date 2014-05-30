user = CreateAdminService.call
puts "CREATED ADMIN USER: #{user.email}"

AuthenticationProvider.create(name: 'facebook')
AuthenticationProvider.create(name: 'twitter')
puts "CREATED AUTHENTICATIONPROVIDERS: #{AuthenticationProvider.all.map(&:name).to_sentence}"
