# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id               :bigint           not null, primary key
#  cover_image_data :json
#  directions       :json             not null
#  ingredients      :json             not null
#  name             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :bigint           not null
#
# Indexes
#
#  index_recipes_on_account_id           (account_id)
#  index_recipes_on_name_and_account_id  (name,account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Recipe < ApplicationRecord
  include Filterable
  include ImageUploader::Attachment(:cover_image)

  belongs_to :account

  has_many :recipe_stories, dependent: :destroy

  has_many :stories, through: :recipe_stories

  validates :name,
            presence: true,
            length: { maximum: 256 },
            uniqueness: { scope: :account_id }

  validates :ingredients, presence: true
  validates :directions, presence: true

  scope :filter_by_account, ->(account_id) { where account_id: account_id }
  scope :filter_by_name, ->(name) { where 'name ILIKE ?', "#{name}%" }
end
