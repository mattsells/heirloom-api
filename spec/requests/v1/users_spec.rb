# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stories', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET /v1/users/:id' do
    context 'when the record exists' do
      it 'responds with the user' do
        get v1_user_path(user), headers: sign_in(user)

        expect(id_of(response)).to eq user.id
      end

      it 'responds with http status ok' do
        get v1_user_path(user), headers: sign_in(user)

        expect(response).to have_http_status :ok
      end
    end

    context 'when the record does not exist' do
      it 'responds with http status not_found' do
        get v1_user_path('invalid'), headers: sign_in(user)

        expect(response).to have_http_status :not_found
      end
    end

    context 'when the user is not authenticated' do
      it 'responds with http status unauthorized' do
        get v1_user_path(user)

        expect(response).to have_http_status :unauthorized
      end
    end

    context 'when the user is not authorized' do
      it 'responds with http status forbidden' do
        other_user = FactoryBot.create(:user)

        get v1_user_path(other_user), headers: sign_in(user)

        expect(response).to have_http_status :forbidden
      end
    end
  end
end
