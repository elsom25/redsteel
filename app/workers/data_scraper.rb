class DataScraper
  include Sidekiq::Worker
  vattr_initialize :user, :data

  class << self
    def perform(user, data)
      new(user, data).update_user!
    end
  end

  def update_user
    fail 'must be implemented by subclasses'
  end

  def update_user!
    update_user
    user.save!
  end

protected

  def set_location
    [:locality, :region, :country_name].each do |field|
      @user.send("#{field}=", address.send(field)) unless @user.send(field).present?
    end
  end

  def address
    fail 'must be implemented by subclasses'
  end
end
