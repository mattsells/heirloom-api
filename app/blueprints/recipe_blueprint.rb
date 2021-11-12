# frozen_string_literal: true

class RecipeBlueprint < Blueprinter::Base
  identifier :id

  fields :account_id,
         :name

  field :cover_image_url_small do |recipe|
    recipe.cover_image_url(:small)
  end

  field :cover_image_url_medium do |recipe|
    recipe.cover_image_url(:medium)
  end

  field :cover_image_url_large do |recipe|
    recipe.cover_image_url(:large)
  end

  view :extended do
    association :stories, blueprint: StoryBlueprint

    fields :cover_image_data, :directions, :ingredients
  end
end
