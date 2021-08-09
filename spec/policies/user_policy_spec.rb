# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let(:user) { FactoryBot.create(:user) }

  permissions '.scope' do
    let(:scope) { Pundit.policy_scope!(user, User) }

    it 'returns all records' do
      FactoryBot.create_list(:user, 5)

      expect(scope.count).to eq(User.count)
    end
  end

  permissions :show? do
    context 'when the record is the user' do
      let(:record) { user }

      it 'permits' do
        expect(described_class).to permit(user, record)
      end
    end

    context 'when the record is not the user' do
      let(:record) { FactoryBot.create(:user) }

      it 'does not permit' do
        expect(described_class).not_to permit(user, record)
      end
    end
  end
end
