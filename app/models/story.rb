# frozen_string_literal: true

class Story < ApplicationRecord
  include ImageUploader::Attachment(:image)
  include VideoUploader::Attachment(:video)

  belongs_to :account

  has_many :recipe_stories, dependent: :destroy

  has_many :recipes, through: :recipe_stories

  enum content_type: {
    image: 0,
    video: 1
  }

  enum story_type: {
    artifact: 0,
    direction: 1,
    memory: 2
  }
end
