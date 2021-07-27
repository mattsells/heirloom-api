# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    password { 'password' }

    sequence(:email) { |n| "user+#{n}@example.com" }
  end
end
