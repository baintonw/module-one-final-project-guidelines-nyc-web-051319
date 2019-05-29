class AddEpisodeNameToView <
  def change
    add_column :views, :name, :string
  end
end

# NOT MIGRATED YET!
