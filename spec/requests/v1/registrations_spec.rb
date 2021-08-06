# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'POST /v1/users' do
    context 'when the params are valid' do
      let(:params) do
        {
          user: {
            email: 'user+1@example.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      it 'creates a new user' do
        expect { post v1_user_registration_path, params: params }.to change(User, :count).by 1
      end

      it 'responds with http status created' do
        post v1_user_registration_path, params: params
        expect(response).to have_http_status(:created)
      end

      it 'responds with the user json' do
        post v1_user_registration_path, params: params
        expect(body_of(response).keys).to include(*%i[id email])
      end
    end

    context 'when the params are not valid' do
      let(:params) do
        {
          user: {
            email: 'user',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      it 'responds with http status bad_request' do
        post v1_user_registration_path, params: params
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when the user already exists' do
      before do
        FactoryBot.create(:user, email: 'user+1@example.com')
      end

      let(:params) do
        {
          user: {
            email: 'user+1@example.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      it 'responds with http status bad request' do
        post v1_user_registration_path, params: params
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
