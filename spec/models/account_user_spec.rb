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
require 'rails_helper'

RSpec.describe AccountUser, type: :model do
  let(:record) { FactoryBot.create(:account_user) }

  describe 'Attributes' do
    describe 'role' do
      it do
        is_expected.to define_enum_for(:role).with_values(
          standard: 0,
          admin: 1,
          owner: 2
        )
      end

      it 'defaults to "standard"' do
        expect(record.role).to eq 'standard'
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:account) }
    it { is_expected.to belong_to(:user) }
  end
end
