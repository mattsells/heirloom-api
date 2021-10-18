# frozen_string_literal: true

class RecipeBlueprint < Blueprinter::Base
  identifier :id

  fields :account_id,
         :cover_image_url,
         :name

  view :extended do
    association :stories, blueprint: StoryBlueprint

    fields :directions, :ingredients
  end
end
