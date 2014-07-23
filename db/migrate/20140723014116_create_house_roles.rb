class CreateRoles < ActiveRecord::Migration
  def change
    create_table :house_roles do |t|
      t.belongs_to :house,      null: false
      t.belongs_to :user,       null: false
      t.integer    :roles_mask, null: false, default: 1
      t.timestamps
    end
    add_index :house_roles, [:house_id, :user_id]
    add_index :house_roles, :house_id
  end
end
