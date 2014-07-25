admin = CreateAdminService.call
puts "CREATED ADMIN USER: #{admin.email}"

house = CreateAdminHouseService.call(admin)
puts "CREATED ADMIN HOUSE: #{house.name}"

providers = CreateAuthenticationProvidersService.call
puts "CREATED AUTHENTICATION PROVIDERS: #{providers.to_sentence}"
