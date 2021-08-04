require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:account) { user.accounts.first }
  let!(:recipes) { FactoryBot.create_list(:recipe, 3, account: account) }

  describe "GET /v1/recipes" do
    context 'when the user is signed in' do
      before { sign_in(user) }

      context 'when the user is authorized' do
        before { FactoryBot.create_list(:recipe, 3) }
  
        it 'returns only records that the user has access to' do
          get v1_recipes_path
          byebug
        end
  
        # it 'renders the records with the blueprint'
        # it 'filters the records on account_id'
        # it 'filters the records on name'
      end
    end
  end
end
