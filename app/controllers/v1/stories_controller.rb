# frozen_string_literal: true

module V1
  class StoriesController < ApiController
    def index
      authorize Story

      records = policy_scope(Story)
                .sift(on(:account, :content_type, :story_type, :name))

      render json: ::StoryBlueprint.render(records, blueprint_view)
    end

    def show
      record = Story.find(params[:id])

      authorize record

      render json: ::StoryBlueprint.render(record, blueprint_view)
    end

    def create
      record = Story.new(story_params)

      authorize record

      record.save!

      render json: ::StoryBlueprint.render(record, blueprint_view)
    end

    def update
      record = Story.find(params[:id])

      record.assign_attributes(story_params)

      authorize record

      record.save!

      render json: ::StoryBlueprint.render(record, blueprint_view)
    end

    def destroy
      record = Story.find(params[:id])

      authorize record

      record.destroy!

      render success(I18n.t('general.destroyed'))
    end

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
