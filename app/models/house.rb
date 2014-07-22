class House < ActiveRecord::Base
  resourcify
  after_save :set_names

  class << self
    def users(house)
      User.with_any_role([{ name: :owner, resource: house }, { name: :resident, resource: house }])
    end

    def owners(house)
      User.with_role(:owner, house)
    end

    def residents(house)
      User.with_role(:resident, house)
    end
  end

  def users
    House.users(self)
  end

  def owners
    House.owners(self)
  end

  def residents
    House.residents(self)
  end

protected

  def set_names
    self.internal_name = "H-#{Date.today.yday}-#{id.to_s.rjust(4, '0')}"
    # self.friendly_name ||= "#{self.users.first.name}'s House" if self.users.present?
    self.save
  end
end
