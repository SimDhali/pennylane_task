class Recipe < ApplicationRecord
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients

    def mark_as_tried
        self.tried = true
        save
    end
    
      # Method to unmark as tried
    def unmark_as_tried
        self.tried = false
        save
    end
end
