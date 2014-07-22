class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :name
      t.string :token, null: false

      t.timestamps
    end
    add_index :houses, :token, unique: true
  end
end
