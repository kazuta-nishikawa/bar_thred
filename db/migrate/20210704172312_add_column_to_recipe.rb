class AddColumnToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :base, :integer
    add_column :recipes, :technique, :integer
  end
end
