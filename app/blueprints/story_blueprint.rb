# frozen_string_literal: true

class StoryBlueprint < Blueprinter::Base
  identifier :id

  fields :account_id,
         :content_type,
         :description,
         :image_url,
         :name,
         :story_type,
         :video_url

  view :extended do
    identifier :id
  end
end
