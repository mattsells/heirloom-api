# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountUserPolicy, type: :policy do
  let(:user) { FactoryBot.create(:user) }

  permissions '.scope' do
    let(:scope) { Pundit.policy_scope!(user, AccountUser) }

    before do
      # Add user to another account
      account = FactoryBot.create(:account)
      FactoryBot.create(:account_user, account: account, user: user)

      # Add users to both of the accounts the user is on
      FactoryBot.create_list(:account_user, 3, account: account)
      FactoryBot.create_list(:account_user, 3, account: user.own_account)

      # Create unrelated users
      FactoryBot.create_list(:user, 3)
    end

    it 'scopes to account users on all user accounts' do
      expected_ids = user.accounts.first.account_users.pluck(:id) + user.accounts.last.account_users.pluck(:id)

      expect(scope.pluck(:id)).to contain_exactly(*expected_ids)
    end
  end

  permissions :index? do
    it 'permits' do
      expect(described_class).to permit(user, AccountUser)
    end
  end
end
