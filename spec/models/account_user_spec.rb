# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountUser, type: :model do
  let(:record) { FactoryBot.create(:account_user) }

  describe 'Attributes' do
    describe 'role' do
      it { is_expected.to define_enum_for(:role).with_values(
        standard: 0,
        admin: 1,
        owner: 2
      ) }

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
