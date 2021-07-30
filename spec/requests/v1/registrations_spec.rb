# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Rooms', type: :request do
  before do
    sign_in(user)
  end

  describe 'POST /rooms' do
    it 'displays the rooms index page' do
      get rooms_path
      expect(response).to render_template(:index)
    end
  end
end
