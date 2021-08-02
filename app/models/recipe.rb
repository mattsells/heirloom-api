# frozen_string_literal: true

class Recipe < ApplicationRecord
  include ImageUploader::Attachment(:cover_image)

  belongs_to :account

  validates :name,
            presence: true,
            length: { maximum: 200 },
            uniqueness: { scope: :account_id }

  validates :ingredients, presence: true
  validates :directions, presence: true
end
