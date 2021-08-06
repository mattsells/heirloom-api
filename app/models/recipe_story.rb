# frozen_string_literal: true

class RecipeStory < ApplicationRecord
  belongs_to :recipe
  belongs_to :story
end
