# frozen_string_literal: true

class StoryBlueprint < Blueprinter::Base
  identifier :id

  fields :account_id,
         :content_type,
         :description,
         :name,
         :story_type,
         :video_url

  field :image_url_small do |recipe|
    recipe.image_url(:small)
  end

  field :image_url_medium do |recipe|
    recipe.image_url(:medium)
  end

  field :image_url_large do |recipe|
    recipe.image_url(:large)
  end

  view :extended do
    identifier :id
  end
end
