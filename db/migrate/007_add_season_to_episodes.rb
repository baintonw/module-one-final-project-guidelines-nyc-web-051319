class AddSeasonToEpisodes < ActiveRecord::Migration[4.2]
  add_column :episodes, :season, :string
end
