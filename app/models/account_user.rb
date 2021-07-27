class AccountUser < ApplicationRecord
  belongs_to :account
  belongs_to :user

  enum role: {
    standard: 0,
    admin: 1
  }
end
