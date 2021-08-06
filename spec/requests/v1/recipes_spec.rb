# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:account) { user.accounts.first }

  describe 'GET /v1/recipes' do
    let!(:owned_recipes) { FactoryBot.create_list(:recipe, 3, account: account) }

    before { FactoryBot.create_list(:recipe, 3) }

    context 'when the user is authorized' do
      it 'returns only records that the user has access to' do
        get v1_recipes_path, headers: sign_in(user)

        expect(ids(response)).to contain_exactly(*owned_recipes.pluck(:id))
      end

      it 'renders the records with the normal blueprint by default' do
        get v1_recipes_path, headers: sign_in(user)

        record = body_of(response).first

        expect(record.keys).to contain_exactly(
          :account_id,
          :cover_image,
          :id,
          :directions,
          :ingredients,
          :name
        )
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

      it 'filters the records on name' do
        recipe = FactoryBot.create(:recipe, account: account, name: 'zzzz')

        params = {
          filters: {
            name: 'zz'
          }
        }

        get v1_recipes_path, headers: sign_in(user), params: params

        expect(ids(response)).to contain_exactly(recipe.id)
      end
    end

    context 'when the user is not authenticated' do
      it 'returns http status unauthorized' do
        get v1_recipes_path

        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe 'POST /v1/recipes' do
    let(:valid_params) do
      {
        recipe: {
          account_id: account.id,
          directions: ['Step 1', 'Step 2'].to_s,
          ingredients: ['Ingredient 1', 'Ingredient 2'].to_s,
          name: 'New Recipe'
        }
      }
    end

    let(:invalid_params) do
      {
        recipe: {
          account_id: account.id,
          directions: ['Step 1', 'Step 2'].to_s,
          ingredients: ['Ingredient 1', 'Ingredient 2'].to_s,
          name: nil
        }
      }
    end

    context 'when the params are valid' do
      it 'creates a recipe' do
        expect { post v1_recipes_path, headers: sign_in(user), params: valid_params.to_json }.to change { Recipe.count }.by 1
      end

      it 'responds with the new recipe' do
        post v1_recipes_path, headers: sign_in(user), params: valid_params.to_json

        expect(body_of(response)).to match(hash_including(valid_params[:recipe]))
      end
    end

    context 'when the params are invalid' do
      it 'returns http status bad_request' do
        post v1_recipes_path, headers: sign_in(user), params: invalid_params.to_json

        expect(response).to have_http_status :bad_request
      end
    end

    context 'when the user is not authenticated' do
      it 'returns http status unauthorized' do
        post v1_recipes_path, params: valid_params.to_json

        expect(response).to have_http_status :unauthorized
      end
    end

    context 'when the user is not authorized' do
      it 'returns http status forbidden' do
        user = FactoryBot.create(:user)

        post v1_recipes_path, headers: sign_in(user), params: valid_params.to_json

        expect(response).to have_http_status :forbidden
      end
    end
  end
end
