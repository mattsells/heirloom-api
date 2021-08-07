# frozen_string_literal: true

class StoryBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :account_id,
           :content_type,
           :description,
           :image_url,
           :name,
           :story_type,
           :video_url
  end

  view :extended do
    include_view :normal
  end
end
