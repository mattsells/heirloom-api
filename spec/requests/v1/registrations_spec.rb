# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'POST /v1/users/sign_in' do
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

      it 'responds with the user json' do
      end
    end

    context 'when the params are not valid' do
    end

    context 'when the user already exists' do
    end
  end
end
