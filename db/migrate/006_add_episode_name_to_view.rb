class AddEpisodeNameToView < ActiveRecord::Migration[4.2]
  def change
    add_column :views, :name, :string
  end
end

# NOT MIGRATED YET!
