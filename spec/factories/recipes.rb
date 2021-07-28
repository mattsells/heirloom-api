# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    name { 'MyString' }
    account { nil }
    ingredients { '' }
  end
end
