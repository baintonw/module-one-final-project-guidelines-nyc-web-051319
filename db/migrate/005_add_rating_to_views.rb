class AddRatingToViews < ActiveRecord::Migration[4.2]
  def change
    add_column :views, :rating, :integer
  end
end
