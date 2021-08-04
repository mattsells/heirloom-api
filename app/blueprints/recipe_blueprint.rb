# frozen_string_literal: true

class RecipeBlueprint < Blueprinter::Base
  identifier :id

  fields :directions, :ingredients, :name

  field :cover_image, &:cover_image_url
end
