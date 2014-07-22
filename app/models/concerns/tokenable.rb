module Tokenable
  extend ActiveSupport::Concern

  included do
    before_create :generate_token
  end

protected

  def generate_token
    self.token = SecureRandom.urlsafe_base64(16)
  end
end
