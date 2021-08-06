# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_story do
    association :recipe
    association :story
  end
end
