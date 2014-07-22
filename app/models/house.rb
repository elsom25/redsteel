class House < ActiveRecord::Base
  include Tokenable
  before_save :set_name

  def to_param
    token
  end

protected

  def set_name
    # self.name ||= "#{self.users.first.name}'s House" if self.users.present?
  end
end
