class RecipesController < ApplicationController
  def index
    if params[:ingredients]
      ingredient_keywords = params[:ingredients].split(',').map(&:strip)
      ingredients = Ingredient.where('name ILIKE ANY (array[?])', ingredient_keywords.map { |kw| "%#{kw}%" })

      if ingredients.any?
        @recipes = Recipe
                    .select('recipes.*, COUNT(recipe_ingredients.id) as matching_ingredients_count')
                    .joins(:ingredients)
                    .where(ingredients: { id: ingredients })
                    .group('recipes.id')
                    .order('matching_ingredients_count DESC')
                    .limit(20)
                    .map do |recipe|
                      total_ingredients_count = recipe.ingredients.size
                      matching_fraction = "#{recipe.matching_ingredients_count}/#{total_ingredients_count}"
                      matching_ratio = recipe.matching_ingredients_count.to_f / total_ingredients_count
                      recipe.define_singleton_method(:matching_fraction) { matching_fraction }
                      recipe.define_singleton_method(:matching_ratio) { matching_ratio }
                      recipe
                    end.sort_by { |recipe| -recipe.matching_ratio }
      else
        @recipes = []
      end
    else
      @recipes = Recipe.all
    end
  end
end
