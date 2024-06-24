# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'
# Load the JSON file
file = File.read(Rails.root.join('db/recipes.json'))
recipes = JSON.parse(file)

# Clear existing data
Recipe.destroy_all
Ingredient.destroy_all
RecipeIngredient.destroy_all

recipes.each do |recipe_data|
  recipe = Recipe.create(
    name: recipe_data['title'],
    description: "#{recipe_data['prep_time']} min prep, #{recipe_data['cook_time']} min cook",
    ratings: recipe_data['ratings'],
    cuisine: recipe_data['cuisine'],
    category: recipe_data['category'],
    author: recipe_data['author'],
    image: recipe_data['image']
  )

  recipe_data['ingredients'].each do |ingredient|
    ingredient_record = Ingredient.find_or_create_by(name: ingredient)
    RecipeIngredient.create(recipe: recipe, ingredient: ingredient_record)
  end
end

