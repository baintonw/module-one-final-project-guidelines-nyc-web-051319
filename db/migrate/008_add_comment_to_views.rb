class AddCommentToViews < ActiveRecord::Migration[4.2]
  add_column :views, :comment, :string
end
