# frozen_string_literal: true

class Recipe < ApplicationRecord
  belongs_to :account

  validates :name, presence: true, length: { maximum: 200 }
end
