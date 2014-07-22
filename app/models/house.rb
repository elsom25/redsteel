class House < ActiveRecord::Base
  after_save :set_names

protected

  def set_names
    self.internal_name = "H-#{Date.today.yday}-#{id.to_s.rjust(4, '0')}"
    # self.friendly_name ||= "#{self.users.first.name}'s House" if self.users.present?
    self.save
  end
end
