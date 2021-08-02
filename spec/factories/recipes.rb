# frozen_string_literal: true

require 'support/attachments'

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
