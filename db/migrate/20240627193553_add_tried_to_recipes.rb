class AddTriedToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :tried, :boolean
  end
end
