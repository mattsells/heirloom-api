# frozen_string_literal: true

module V1
  class RecipesController < ApiController
    def index
      authorize Recipe

      records = policy_scope(Recipe)
                .extended_includes(params, :stories)
                .sift(on(:account, :name))

      render json: ::RecipeBlueprint.render(records, blueprint_view)
    end

    def show
      record = Recipe.find(params[:id])

      authorize record

      render json: ::RecipeBlueprint.render(record, blueprint_view)
    end

    def create
      record = Recipe.new(recipe_params)

      authorize record

      record.save!

      render json: ::RecipeBlueprint.render(record, blueprint_view)
    end

    def update
      record = Recipe.find(params[:id])

      record.assign_attributes(recipe_params)

      authorize record

      record.save!

      render json: ::RecipeBlueprint.render(record, blueprint_view)
    end

    def destroy
      record = Recipe.find(params[:id])

      authorize record

      record.destroy!

      render success(I18n.t('general.destroyed'))
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
