class AddDefaultToUserRole < ActiveRecord::Migration
  def change
    change_column :users, :role, :integer, null: false, default: 0
  end
end
