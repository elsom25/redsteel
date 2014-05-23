class RoleNotNil < ActiveRecord::Migration
  def change
    change_column :users, :role, :integer, null: false
  end
end
