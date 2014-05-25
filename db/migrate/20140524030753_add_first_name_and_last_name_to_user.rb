class AddFirstNameAndLastNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string

    # migrate and remove old column
    User.select(&:name).each do |user|
      user.first_name, user.last_name = user.name.split
      user.save!
    end
    remove_column :users, :name
  end
end
