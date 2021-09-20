# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Recipes', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:account) { user.own_account }

  let(:valid_params) do
    {
      recipe: {
        account_id: account.id,
        cover_image: Support::Attachments.image_data,
        directions: ['Step 1', 'Step 2'].to_json,
        ingredients: ['Ingredient 1', 'Ingredient 2'].to_json,
        name: 'New Recipe'
      }
    }
  end

  let(:invalid_params) do
    {
      recipe: {
        account_id: account.id,
        name: nil
      }
    }
  end

  describe 'GET /v1/recipes' do
    let!(:owned_recipes) { FactoryBot.create_list(:recipe, 3, account: account) }

    before { FactoryBot.create_list(:recipe, 3) }

    context 'when the user is authorized' do
      it 'returns only records that the user has access to' do
        get v1_recipes_path, headers: sign_in(user)

        expect(ids_of(response)).to contain_exactly(*owned_recipes.pluck(:id))
      end

      it 'renders the records with the normal blueprint by default' do
        get v1_recipes_path, headers: sign_in(user)

        record = body_of(response).first

        expect(record.keys).to contain_exactly(
          :account_id,
          :cover_image_url,
          :id,
          :name
        )
      end

      it 'renders the records with the extended blueprint if specified' do
        get v1_recipes_path, headers: sign_in(user), params: { extended: true }

        record = body_of(response).first

        expect(record.keys).to contain_exactly(
          :account_id,
          :cover_image_url,
          :id,
          :directions,
          :ingredients,
          :name,
          :stories
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

        expect(ids_of(response)).to contain_exactly(recipe.id)
      end

      it 'filters the records on name' do
        recipe = FactoryBot.create(:recipe, account: account, name: 'zzzz')

        params = {
          filters: {
            name: 'zz'
          }
        }

        get v1_recipes_path, headers: sign_in(user), params: params

        expect(ids_of(response)).to contain_exactly(recipe.id)
      end
    end

    context 'when the user is not authenticated' do
      it 'responds with http status unauthorized' do
        get v1_recipes_path

        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe 'GET /v1/recipe/:id' do
    let(:recipe) { FactoryBot.create(:recipe, account: account) }

    context 'when the record exists' do
      it 'responds with the recipe' do
        get v1_recipe_path(recipe), headers: sign_in(user)

        expect(id_of(response)).to eq recipe.id
      end

      it 'responds with http status ok' do
        get v1_recipe_path(recipe), headers: sign_in(user)

        expect(response).to have_http_status :ok
      end
    end

    context 'when the record does not exist' do
      it 'responds with http status not_found' do
        get v1_recipe_path('invalid'), headers: sign_in(user)

        expect(response).to have_http_status :not_found
      end
    end

    context 'when the user is not authenticated' do
      it 'responds with http status unauthorized' do
        get v1_recipe_path(recipe)

        expect(response).to have_http_status :unauthorized
      end
    end

    context 'when the user is not authorized' do
      it 'responds with http status forbidden' do
        user = FactoryBot.create(:user)

        get v1_recipe_path(recipe), headers: sign_in(user)

        expect(response).to have_http_status :forbidden
      end
    end
  end

  describe 'POST /v1/recipes' do
    context 'when the params are valid' do
      it 'creates a recipe' do
        expect { post v1_recipes_path, headers: sign_in(user), params: valid_params.to_json }.to change(Recipe, :count).by 1
      end

      it 'responds with the new recipe' do
        post v1_recipes_path, headers: sign_in(user), params: valid_params.to_json

        expect(body_of(response)).to match(hash_including(valid_params[:recipe].slice(:name)))
      end
    end

    context 'when the params are invalid' do
      it 'responds with http status bad_request' do
        post v1_recipes_path, headers: sign_in(user), params: invalid_params.to_json

        expect(response).to have_http_status :bad_request
      end
    end

    context 'when the user is not authenticated' do
      it 'responds with http status unauthorized' do
        post v1_recipes_path, params: valid_params.to_json

        expect(response).to have_http_status :unauthorized
      end
    end

    context 'when the user is not authorized' do
      it 'responds with http status forbidden' do
        user = FactoryBot.create(:user)

        post v1_recipes_path, headers: sign_in(user), params: valid_params.to_json

        expect(response).to have_http_status :forbidden
      end
    end
  end

  describe 'PATCH /v1/recipes/:id' do
    let(:recipe) { FactoryBot.create(:recipe, account: account) }

    let(:params) do
      {
        recipe: {
          name: 'Updated name'
        }
      }
    end

    context 'when the params are valid' do
      it 'updates the recipe' do
        patch v1_recipe_path(recipe), headers: sign_in(user), params: params.to_json
      end

      it 'responds with the updated recipe' do
        patch v1_recipe_path(recipe), headers: sign_in(user), params: params.to_json

        expect(body_of(response)).to match(hash_including(params[:recipe].slice(:name)))
      end
    end

    context 'when the params are invalid' do
      it 'responds with http status bad_request' do
        patch v1_recipe_path(recipe), headers: sign_in(user), params: invalid_params.to_json

        expect(response).to have_http_status :bad_request
      end
    end

    context 'when the user is not authenticated' do
      it 'responds with http status unauthorized' do
        patch v1_recipe_path(recipe), params: params.to_json

        expect(response).to have_http_status :unauthorized
      end
    end

    context 'when the user is not authorized' do
      it 'responds with http status forbidden' do
        user = FactoryBot.create(:user)

        patch v1_recipe_path(recipe), headers: sign_in(user), params: params.to_json

        expect(response).to have_http_status :forbidden
      end
    end
  end

  describe 'DELETE /v1/recipes/:id' do
    let(:recipe) { FactoryBot.create(:recipe, account: account) }

    context 'when the record exists' do
      it 'destroys the recipe' do
        delete v1_recipe_path(recipe), headers: sign_in(user)
      end

      it 'responds with http status ok' do
        delete v1_recipe_path(recipe), headers: sign_in(user)

        expect(response).to have_http_status :ok
      end
    end

    context 'when the record does not exist' do
      it 'responds with http status not_found' do
        delete v1_recipe_path('invalid'), headers: sign_in(user)

        expect(response).to have_http_status :not_found
      end
    end

    context 'when the user is not authenticated' do
      it 'responds with http status unauthorized' do
        delete v1_recipe_path(recipe)

        expect(response).to have_http_status :unauthorized
      end
    end

    context 'when the user is not authorized' do
      it 'responds with http status forbidden' do
        user = FactoryBot.create(:user)

        delete v1_recipe_path(recipe), headers: sign_in(user)

        expect(response).to have_http_status :forbidden
      end
    end
  end
end
