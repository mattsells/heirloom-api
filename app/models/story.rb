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
class Story < ApplicationRecord
  include Filterable
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

  scope :filter_by_account, ->(account_id) { where account_id: account_id }
  scope :filter_by_content_type, ->(content_type) { where content_type: content_type }
  scope :filter_by_name, ->(name) { where 'name ILIKE ?', "#{name}%" }
  scope :filter_by_story_type, ->(story_type) { where story_type: story_type }
end
