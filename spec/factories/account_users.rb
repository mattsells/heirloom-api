# frozen_string_literal: true

FactoryBot.define do
  factory :account_user do
    association :account
    association :user
  end
end
