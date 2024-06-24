class RecipesController < ApplicationController
  def index
    if params[:ingredients]
      ingredient_names = params[:ingredients].split(',').map(&:strip)
      ingredients = Ingredient.where(name: ingredient_names)

      if ingredients.size == ingredient_names.size
        @recipes = Recipe.joins(:ingredients).where(ingredients: { id: ingredients }).group('recipes.id').having('COUNT(recipes.id) = ?', ingredients.size)
      else
        @recipes = []
      end
    else
      @recipes = Recipe.all
    end
  end
end
