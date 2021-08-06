# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeStory, type: :model do
  let(:record) { FactoryBot.create(:recipe_story) }

  describe 'Associations' do
    it { is_expected.to belong_to(:recipe) }
    it { is_expected.to belong_to(:story) }
  end
end
