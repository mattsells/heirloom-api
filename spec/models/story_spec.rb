# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story, type: :model do
  let(:record) { FactoryBot.create(:story) }

  describe 'Attributes' do
    describe 'image' do
      let(:record) { FactoryBot.create(:story, :with_image) }

      it 'is a file attachment' do
        expect(record.image.mime_type).to eq('image/jpeg')
      end
    end

    describe 'video' do
      let(:record) { FactoryBot.create(:story, :with_video) }

      it 'is a file attachment' do
        expect(record.video.mime_type).to eq('video/mp4')
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:account) }
    it { is_expected.to have_many(:recipe_stories).dependent(:destroy) }
    it { is_expected.to have_many(:recipes).through(:recipe_stories) }
  end
end
