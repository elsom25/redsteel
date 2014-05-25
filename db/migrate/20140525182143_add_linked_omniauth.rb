class AddLinkedOmniauth < ActiveRecord::Migration
  def change
    create_table :linked_omniauths do |t|
      t.integer :user_id,  null: false
      t.string  :uid,      null: false
      t.string  :provider, null: false
      t.string  :nickname
      t.text    :data
    end

    add_index :linked_omniauths, [:provider, :uid], unique: true
  end
end
