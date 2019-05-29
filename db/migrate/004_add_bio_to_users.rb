class AddBioToUsers < ActiveRecord::Migration[4.2]
  # Adds bio column to users
  def change
    add_column :users, :bio, :string
  end
end
