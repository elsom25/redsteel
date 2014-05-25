class CreateAdminService
  def self.call
    secrets = Rails.application.secrets
    User.find_or_create_by!(email: secrets.admin_email) do |user|
      user.password = user.password_confirmation = secrets.admin_password
      user.admin!
    end
  end
end
