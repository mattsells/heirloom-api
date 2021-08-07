module V1
  class StoriesController < ApplicationController
    def index
      authorize Story

      records = policy_scope(Story)
                .includes(:account)
                .extended_includes(params, :stories)
                .sift(on(:account, :content_type, :story_type, :name))

      render json: ::StoryBlueprint.render(records, blueprint_view)
    end

    # def show
    #   record = Recipe.find(params[:id])

    #   authorize record

    #   render json: ::RecipeBlueprint.render(record)
    # end

    # def create
    #   record = Recipe.new(recipe_params)

    #   authorize record

    #   record.save!

    #   render json: ::RecipeBlueprint.render(record)
    # end

    # def update
    #   record = Recipe.find(params[:id])

    #   record.assign_attributes(recipe_params)

    #   authorize record

    #   record.save!

    #   render json: ::RecipeBlueprint.render(record)
    # end

    # def destroy
    #   record = Recipe.find(params[:id])

    #   authorize record

    #   record.destroy!

    #   render success(I18n.t('general.destroyed'))
    # end

    private

    def story_params
      params.require(:story).permit(
        :account_id,
        :content_type,
        :description,
        :image,
        :name,
        :story_type,
        :video
      )
    end
  end
end
