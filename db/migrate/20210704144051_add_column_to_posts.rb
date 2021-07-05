class AddColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :comment_number, :integer
  end
end
