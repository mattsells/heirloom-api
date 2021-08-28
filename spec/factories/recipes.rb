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
require_relative '../support/attachments'

FactoryBot.define do
  factory :recipe do
    association :account

    sequence(:name) { |n| "Recipe #{n}" }

    trait(:with_cover_image) do
      cover_image { Support::Attachments.image_data }
    end

    trait(:with_directions) do
      directions { ['direction 1', 'direction 2', 'direction_3'].to_json }
    end

    trait(:with_ingredients) do
      ingredients { ['ingredient 1', 'ingredient 2', 'ingredient_3'].to_json }
    end
  end
end
