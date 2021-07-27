# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:record) { FactoryBot.create(:account) }

  describe 'Associations' do
    it { is_expected.to have_many(:account_users).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:account_users) }
  end
end
