# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Sessions', type: :request do
  describe 'POST /v1/users/sign_in' do
    before { FactoryBot.create(:user, email: 'user+1@example.com', password: 'password') }

    context 'when the params are valid' do
      let(:params) do
        {
          user: {
            email: 'user+1@example.com',
            password: 'password'
          }
        }
      end

      it 'responds with http status ok' do
        post v1_user_session_path, params: params
        expect(response).to have_http_status(:ok)
      end

      it 'responds with the user json' do
        post v1_user_session_path, params: params
        expect(body_of(response).keys).to include(*%i[id email])
      end
    end

    context 'when the params are not valid' do
      let(:params) do
        {
          user: {
            email: 'user',
            password: 'wrong'
          }
        }
      end

      it 'responds with http status unauthorized' do
        post v1_user_session_path, params: params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
