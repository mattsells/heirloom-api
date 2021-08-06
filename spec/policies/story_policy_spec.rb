# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoryPolicy, type: :policy do
  let(:user) { FactoryBot.create(:user) }

  permissions '.scope' do
    let(:scope) { Pundit.policy_scope!(user, Story) }

    before do
      FactoryBot.create_list(:story, 3, account: user.own_account)

      second_account = FactoryBot.create(:account)
      second_account.users << user

      FactoryBot.create_list(:story, 3, account: second_account)
      FactoryBot.create_list(:story, 3)
    end

    it 'returns only records that are linked to one of the users accounts' do
      expect(scope.pluck(:account_id).uniq).to contain_exactly(*user.account_users.pluck(:account_id))
    end
  end

  permissions :index? do
    it 'permits' do
      expect(described_class).to permit(user, Story)
    end
  end

  permissions :show?, :create?, :update?, :destroy? do
    context 'when the user is a member of the story account' do
      let(:record) { FactoryBot.create(:story, account: user.own_account) }

      it 'permits' do
        expect(described_class).to permit(user, record)
      end
    end

    context 'when the user is not a member of the account' do
      let(:record) { FactoryBot.create(:story) }

      it 'does not permit' do
        expect(described_class).not_to permit(user, record)
      end
    end
  end
end
