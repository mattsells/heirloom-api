# frozen_string_literal: true

class StoryBlueprint < Blueprinter::Base
  identifier :id

	view :normal do
		fields :account_id, :content_type, :description, :name, :story_type

		# rubocop:disable Style/SymbolProc
		field :image do |story|
			story.image_url
		end
	
		field :video do |story|
			story.video_url
		end
		# rubocop:enable Style/SymbolProc
	end

	view :extended do
		include_view :normal
	end
end
