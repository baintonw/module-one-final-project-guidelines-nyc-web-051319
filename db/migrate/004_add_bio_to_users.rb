class AddBioToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :bio, :string
  end
end