# frozen_string_literal: true

# == Schema Information
#
# Table name: account_users
#
#  id         :bigint           not null, primary key
#  role       :integer          default("standard")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_account_users_on_account_id  (account_id)
#  index_account_users_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :account_user do
    association :account
    association :user
  end
end
