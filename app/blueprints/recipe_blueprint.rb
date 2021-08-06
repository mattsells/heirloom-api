# frozen_string_literal: true

class RecipeBlueprint < Blueprinter::Base
  identifier :id

  fields :account_id, :directions, :ingredients, :name

  # rubocop:disable Style/SymbolProc
  field :cover_image do |user|
    user.cover_image_url
  end
  # rubocop:enable Style/SymbolProc
end
