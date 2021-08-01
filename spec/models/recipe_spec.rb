# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:record) { FactoryBot.create(:recipe) }

  let(:account) { FactoryBot.create(:account) }

  describe 'Attributes' do
    describe 'name' do
      subject { FactoryBot.create(:recipe, account: account) }

      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_uniqueness_of(:name).scoped_to(:account_id) }
      it { is_expected.to validate_length_of(:name).is_at_most(200) }
    end

    describe 'ingredients' do
      it { is_expected.to validate_presence_of :ingredients }
    end

    describe 'directions' do
      it { is_expected.to validate_presence_of :directions }
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:account) }
  end
end