# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stories', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:account) { user.own_account }

  let(:valid_params) do
    {
      story: {
        account_id: account.id,
        content_type: 'image',
        description: 'Story description',
        image: Support::Attachments.image_data,
        name: 'New Story',
        story_type: 'artifact'
      }
    }
  end

  let(:invalid_params) do
    {
      recipe: {
        account_id: account.id,
        content_type: 'invalid',
        description: 'Story description',
        name: 'New Story',
        story_type: 'artifact'
      }
    }
  end

  describe 'GET /v1/stories' do
    let!(:owned_records) { FactoryBot.create_list(:story, 3, account: account) }

    before { FactoryBot.create_list(:story, 3) }

    context 'when the user is authorized' do
      it 'returns only records that the user has access to' do
        get v1_stories_path, headers: sign_in(user)

        expect(ids_of(response)).to contain_exactly(*owned_records.pluck(:id))
      end

      it 'renders the records with the normal blueprint by default' do
        get v1_stories_path, headers: sign_in(user)

        record = body_of(response).first

        expect(record.keys).to contain_exactly(
          :account_id,
          :content_type,
          :description,
          :id,
          :image_url,
          :name,
          :story_type,
          :video_url
        )
      end

      it 'renders the records with the extended blueprint if specified' do
        get v1_stories_path, headers: sign_in(user), params: { extended: true }

        record = body_of(response).first

        expect(record.keys).to contain_exactly(
          :account_id,
          :content_type,
          :description,
          :id,
          :image_url,
          :name,
          :story_type,
          :video_url
        )
      end

      it 'filters the records on account_id' do
        account = FactoryBot.create(:account)
        record = FactoryBot.create(:story, account: account)
        FactoryBot.create(:account_user, account: account, user: user)

        params = {
          filters: {
            account: account.id
          }
        }

        get v1_stories_path, headers: sign_in(user), params: params

        expect(ids_of(response)).to contain_exactly(record.id)
      end

      it 'filters the records on name' do
        record = FactoryBot.create(:story, account: account, name: 'zzzz')

        params = {
          filters: {
            name: 'zz'
          }
        }

        get v1_stories_path, headers: sign_in(user), params: params

        expect(ids_of(response)).to contain_exactly(record.id)
      end

      it 'filters the records on content_type' do
        FactoryBot.create(:story, account: account, content_type: 'image')
        FactoryBot.create(:story, account: account, content_type: 'video')

        params = {
          filters: {
            content_type: 'image'
          }
        }

        get v1_stories_path, headers: sign_in(user), params: params

        content_types = body_of(response).map { |recipe| recipe[:content_type] }.uniq
        expect(content_types).to contain_exactly('image')
      end

      it 'filters the records on story_type' do
        FactoryBot.create(:story, account: account, story_type: 'artifact')
        FactoryBot.create(:story, account: account, story_type: 'direction')
        FactoryBot.create(:story, account: account, story_type: 'memory')

        params = {
          filters: {
            story_type: 'artifact'
          }
        }

        get v1_stories_path, headers: sign_in(user), params: params

        story_type = body_of(response).map { |recipe| recipe[:story_type] }.uniq
        expect(story_type).to contain_exactly('artifact')
      end
    end

    context 'when the user is not authenticated' do
      it 'responds with http status unauthorized' do
        get v1_stories_path

        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
