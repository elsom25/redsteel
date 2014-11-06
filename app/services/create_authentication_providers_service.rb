class CreateAuthenticationProvidersService
  def self.call(owners)
    AuthenticationProvider.find_or_create_by!(name: 'facebook')
    AuthenticationProvider.find_or_create_by!(name: 'twitter')
    AuthenticationProvider.pluck(:name)
  end
end
