class HouseRole < ActiveRecord::Base
  include RoleModel
  roles :resident, :owner # position 0 is the default

  belongs_to :user
  belongs_to :house

  class << self
    def with_any_role(*roles)
      where("#{role_mask_column} & :role_mask > 0", role_mask: mask_for(*roles))
    end

    def with_all_roles(*roles)
      where("#{role_mask_column} & :role_mask = :role_mask", role_mask: mask_for(*roles))
    end

    def with_only_roles(*roles)
      where("#{role_mask_column} = :role_mask", role_mask: mask_for(*roles))
    end

  protected

    def role_mask_column
      "#{quoted_table_name}.#{connection.quote_column_name roles_attribute_name}"
    end
  end
end
