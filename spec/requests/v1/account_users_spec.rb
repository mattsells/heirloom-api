# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::AccountUsers', type: :request do
  let(:account) { user.own_account }
  let(:user) { FactoryBot.create(:user) }

  describe 'GET /v1/index' do
    context 'when the user is authorized' do
      before do
        FactoryBot.create(:account_user, account: user.own_account)
        FactoryBot.create(:account_user)
      end

      it 'returns only records that the user has access to' do
        get v1_account_users_path, headers: sign_in(user)

        expect(ids_of(response, :account_users)).to contain_exactly(*account.account_users.pluck(:id))
      end

      it 'renders the records with the normal blueprint by default' do
        get v1_account_users_path, headers: sign_in(user)

        record = body_of(response, :account_users).first

        expect(record.keys).to contain_exactly(
          :account_id,
          :id,
          :role,
          :user_id
        )
      end

      it 'renders the records with the extended blueprint if specified' do
        get v1_account_users_path, headers: sign_in(user), params: { extended: true }

        record = body_of(response, :account_users).first

        expect(record.keys).to contain_exactly(
          :account,
          :account_id,
          :id,
          :role,
          :user,
          :user_id
        )
      end

      it 'filters the records on user_id' do
        params = {
          filters: {
            user: user.id
          }
        }

        get v1_account_users_path, headers: sign_in(user), params: params

        expect(ids_of(response, :account_users)).to contain_exactly(*user.account_users.pluck(:id))
      end
    end

    context 'when the user is not authenticated' do
      it 'responds with http status unauthorized' do
        get v1_account_users_path

        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
