# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipePolicy, type: :policy do
  let(:user) { FactoryBot.create(:user) }

  permissions '.scope' do
    let(:scope) { Pundit.policy_scope!(user, Recipe) }

    before do
      FactoryBot.create_list(:recipe, 3, account: user.own_account)

      second_account = FactoryBot.create(:account)
      second_account.users << user

      FactoryBot.create_list(:recipe, 3, account: second_account)
      FactoryBot.create_list(:recipe, 3)
    end

    it 'returns only records that are linked to one of the users accounts' do
      expect(scope.pluck(:account_id).uniq).to contain_exactly(*user.account_users.pluck(:account_id))
    end
  end

  permissions :index? do
    it 'permits' do
      expect(described_class).to permit(user, Recipe)
    end
  end

  permissions :show?, :create?, :update?, :destroy? do
    context 'when the user is a member of the recipe account' do
      let(:record) { FactoryBot.create(:recipe, account: user.own_account) }

      it 'permits' do
        expect(described_class).to permit(user, record)
      end
    end

    context 'when the user is not a member of the account' do
      let(:record) { FactoryBot.create(:recipe) }

      it 'does not permit' do
        expect(described_class).to_not permit(user, record)
      end
    end
  end
end
