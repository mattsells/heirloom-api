# frozen_string_literal: true

class Recipe < ApplicationRecord
  include Filterable
  include ImageUploader::Attachment(:cover_image)

  belongs_to :account

  has_many :recipe_stories, dependent: :destroy

  has_many :stories, through: :recipe_stories

  validates :name,
            presence: true,
            length: { maximum: 200 },
            uniqueness: { scope: :account_id }

  validates :ingredients, presence: true
  validates :directions, presence: true

  scope :filter_by_account, ->(account_id) { where account_id: account_id }
  scope :filter_by_name, ->(name) { where 'name ILIKE ?', "#{name}%" }
end
