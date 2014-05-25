class DataScraper
  include Sidekiq::Worker

  vattr_initialize :user, :data

  def self.perform(user, data)
    self.new(user, data).update_user!
  end

  def update_user
    raise 'must be implemented by subclasses'
  end

  def update_user!
    update_user
    user.save!
  end

protected

  def set_location
    [:locality, :region, :country_name].each do |field|
      @user.send("#{field}=", self.address.send(field)) unless @user.send(field)
    end
  end

  def address
    raise 'must be implemented by subclasses'
  end
end
