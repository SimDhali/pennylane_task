class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.float :ratings
      t.string :cuisine
      t.string :category
      t.string :author
      t.string :image

      t.timestamps
    end
  end
end
