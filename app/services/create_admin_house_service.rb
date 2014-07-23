class CreateAdminHouseService
  def self.call(owners)
    owners = Array(owners)
    House.find_or_create_by!(name: 'redsteel') do |house|
      house.owners = owners
    end
  end
end
