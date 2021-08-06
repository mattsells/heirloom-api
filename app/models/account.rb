# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :account_users,  dependent: :destroy
  has_many :recipes,        dependent: :destroy
  has_many :stories,        dependent: :destroy

  has_many :users, through: :account_users
end
