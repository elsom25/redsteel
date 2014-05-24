class AddAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :street_address, :string
    add_column :users, :locality,       :string
    add_column :users, :postal_code,    :string
    add_column :users, :country_name,   :string
  end
end
