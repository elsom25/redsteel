class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :friendly_name
      t.string :internal_name

      t.timestamps
    end
  end
end
