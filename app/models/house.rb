class House < ActiveRecord::Base
  resourcify
  # has_many :users, through: :roles, source: :resource, source_type: 'User' #TBD: This vs the other thing below
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
    self.class.users(self)
  end

  def owners
    self.class.owners(self)
  end

  def residents
    self.class.residents(self)
  end

protected

  def set_names
    self.internal_name = "H-#{Date.today.yday}-#{id.to_s.rjust(4, '0')}"
    # self.friendly_name ||= "#{users.first.name}'s House" if users.present?
    save
  end
end
