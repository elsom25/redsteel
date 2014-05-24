class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :admin]
  after_initialize :set_default_role, if: :new_record?

  def name
    self.first_name || self.last_name || ''
  end

  def full_name
    "#{self.first_name} #{self.last_name}".strip
  end

protected

  def set_default_role
    self.role ||= :user
  end
end
