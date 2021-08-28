# frozen_string_literal: true

# == Schema Information
#
# Table name: stories
#
#  id           :bigint           not null, primary key
#  content_type :integer          default("image"), not null
#  description  :text
#  image_data   :json
#  name         :string
#  story_type   :integer          default("artifact"), not null
#  video_data   :json
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :bigint           not null
#
# Indexes
#
#  index_stories_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
require 'rails_helper'

RSpec.describe Story, type: :model do
  let(:record) { FactoryBot.create(:story) }

  let(:account) { FactoryBot.create(:account) }

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

  describe 'Scope' do
    it 'filters by account' do
      stories = FactoryBot.create_list(:story, 3, account: account)
      FactoryBot.create_list(:story, 3)

      records = described_class.filter_by_account(account.id)

      expect(records.pluck(:id)).to contain_exactly(*stories.pluck(:id))
    end

    it 'filters by name' do
      story = FactoryBot.create(:story, name: 'Test story')
      FactoryBot.create(:story, name: 'Unmatched')

      records = described_class.filter_by_name('test')

      expect(records.pluck(:id)).to contain_exactly(story.id)
    end

    it 'filters by content type' do
      stories = FactoryBot.create_list(:story, 3, content_type: 'image')
      FactoryBot.create_list(:story, 3, content_type: 'video')

      records = described_class.filter_by_content_type('image')

      expect(records.pluck(:id)).to contain_exactly(*stories.pluck(:id))
    end

    it 'filters by story type' do
      stories = FactoryBot.create_list(:story, 3, story_type: 'artifact')
      FactoryBot.create_list(:story, 3, story_type: 'memory')
      FactoryBot.create_list(:story, 3, story_type: 'direction')

      records = described_class.filter_by_story_type('artifact')

      expect(records.pluck(:id)).to contain_exactly(*stories.pluck(:id))
    end
  end
end
