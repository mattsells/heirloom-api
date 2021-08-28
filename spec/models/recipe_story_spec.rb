# frozen_string_literal: true

# == Schema Information
#
# Table name: recipe_stories
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :bigint           not null
#  story_id   :bigint           not null
#
# Indexes
#
#  index_recipe_stories_on_recipe_id  (recipe_id)
#  index_recipe_stories_on_story_id   (story_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
#  fk_rails_...  (story_id => stories.id)
#
require 'rails_helper'

RSpec.describe RecipeStory, type: :model do
  let(:record) { FactoryBot.create(:recipe_story) }

  describe 'Associations' do
    it { is_expected.to belong_to(:recipe) }
    it { is_expected.to belong_to(:story) }
  end
end
