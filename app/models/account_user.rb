# frozen_string_literal: true

class AccountUser < ApplicationRecord
  belongs_to :account
  belongs_to :user

  enum role: {
    standard: 0,
    admin: 1,
    owner: 2
  }
end
