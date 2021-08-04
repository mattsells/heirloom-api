# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:account) { user.accounts.first }

  describe 'GET /v1/recipes' do
    let!(:owned_recipes) { FactoryBot.create_list(:recipe, 3, account: account) }
    let!(:unowned_recipes) { FactoryBot.create_list(:recipe, 3) }

    context 'when the user is authorized' do
      it 'returns only records that the user has access to' do
        get v1_recipes_path, headers: sign_in(user)

        expect(ids(response)).to contain_exactly(*owned_recipes.pluck(:id))
      end

      it 'renders the records with the requested blueprint' do
      end

      it 'filters the records on account_id' do
        account = FactoryBot.create(:account)
        recipe = FactoryBot.create(:recipe, account: account)
        FactoryBot.create(:account_user, account: account, user: user)

        params = {
          filters: {
            account: account.id
          }
        }

        get v1_recipes_path, headers: sign_in(user), params: params

        expect(ids(response)).to contain_exactly(recipe.id)
      end

      # it 'filters the records on name'
    end

    context 'when the user is not authenticated' do
      it 'returns http status unauthorized' do
        get v1_recipes_path

        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
