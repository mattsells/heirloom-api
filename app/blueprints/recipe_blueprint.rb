# frozen_string_literal: true

class RecipeBlueprint < Blueprinter::Base
  identifier :id

  field :directions, :email, :ingredients

	field :cover_image do |user|
		user.cover_image_url
	end
end
