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
      @recipes = Recipe.all.map do |recipe|
        total_ingredients_count = recipe.ingredients.size
        matching_fraction = "0/#{total_ingredients_count}"
        matching_ratio = 0.0
        recipe.define_singleton_method(:matching_fraction) { matching_fraction }
        recipe.define_singleton_method(:matching_ratio) { matching_ratio }
        recipe
      end
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @submitted_ingredient_keywords = params[:submitted_ingredients].to_s.split(',').map(&:strip)
  end

  def try
    @recipe = Recipe.find(params[:id])
    if @recipe.mark_as_tried
      redirect_to @recipe, notice: 'Recipe marked as tried.'
    else
      redirect_to @recipe, alert: 'Failed to mark recipe as tried.'
    end
  end

  def untry
    @recipe = Recipe.find(params[:id])
    if @recipe.unmark_as_tried
      redirect_to @recipe, notice: 'Recipe marked as untried.'
    else
      redirect_to @recipe, alert: 'Failed to mark recipe as untried.'
    end
  end
end
