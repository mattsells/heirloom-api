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
FactoryBot.define do
  factory :story do
    association :account

    trait(:with_image) do
      content_type { 'image' }
      image { Support::Attachments.image_data }
    end

    trait(:with_video) do
      content_type { 'video' }
      video { Support::Attachments.video_data }
    end
  end
end
