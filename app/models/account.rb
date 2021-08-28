# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account < ApplicationRecord
  has_many :account_users,  dependent: :destroy
  has_many :recipes,        dependent: :destroy
  has_many :stories,        dependent: :destroy

  has_many :users, through: :account_users
end
