class House < ActiveRecord::Base
  include Tokenable

protected
  has_many :house_roles
  has_many :house_role_owners, -> { with_all_roles(:owner) }, class_name: HouseRole.name
  has_many :house_role_residents, -> { with_all_roles(:owner) }, class_name: HouseRole.name

public
  has_many :users, -> { uniq }, through: :house_roles
  has_many :owners, -> { uniq }, through: :house_role_owners, source: :user
  has_many :residents, -> { uniq }, through: :house_role_residents, source: :user

  before_save :set_name

  def to_param
    token
  end

protected

  def set_name
    # self.name ||= "#{self.users.first.name}'s House" if self.users.present?
  end
end
