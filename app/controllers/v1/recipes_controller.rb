# frozen_string_literal: true

module V1
  class RecipesController < ApiController
    def index
      authorize Recipe

      records = policy_scope(Recipe).sift(on(:account, :name)).includes(:account)

      # TODO: Add blueprint formatting via request
      render json: ::RecipeBlueprint.render(records)
    end

    def create
      record = Recipe.new(recipe_params)

      authorize record

      record.save!

      render json: ::RecipeBlueprint.render(record)
    end

    private

    def recipe_params
      params.require(:recipe).permit(
        :account_id,
        :cover_image,
        :directions,
        :ingredients,
        :name
      )
    end
  end
end
