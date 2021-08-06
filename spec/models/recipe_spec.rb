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

    describe 'cover_image' do
      let(:record) { FactoryBot.create(:recipe, :with_cover_image) }

      it 'is a file attachment' do
        expect(record.cover_image.mime_type).to eq('image/jpeg')
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:account) }
    it { is_expected.to have_many(:recipe_stories).dependent(:destroy) }
    it { is_expected.to have_many(:stories).through(:recipe_stories) }
  end

  describe 'Scopes' do
    describe 'filter_by_account' do
      it 'filters by account' do
        recipes = FactoryBot.create_list(:recipe, 3, account: account)
        FactoryBot.create_list(:recipe, 3)

        records = described_class.filter_by_account(account.id)

        expect(records.pluck(:id)).to contain_exactly(*recipes.pluck(:id))
      end
    end

    describe 'filter_by_name' do
      it 'filters by account' do
        recipe = FactoryBot.create(:recipe, name: 'Test recipe')
        FactoryBot.create(:recipe, name: 'Unmatched')

        records = described_class.filter_by_name('test')

        expect(records.pluck(:id)).to contain_exactly(recipe.id)
      end
    end
  end
end
