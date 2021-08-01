# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    association :account

    sequence(:name) { |n| "Recipe #{n}" }

    directions { ['direction 1', 'direction 2', 'direction_3'].to_json }
    ingredients { ['ingredient 1', 'ingredient 2', 'ingredient_3'].to_json }
  end
end
