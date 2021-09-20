# frozen_string_literal: true

class RecipeBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :account_id,
           :cover_image_url,
           :name
  end

  view :extended do
    include_view :normal
    association :stories, blueprint: StoryBlueprint

    fields :directions, :ingredients
  end
end
