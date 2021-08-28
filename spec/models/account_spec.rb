# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:record) { FactoryBot.create(:account) }

  describe 'Associations' do
    it { is_expected.to have_many(:account_users).dependent(:destroy) }
    it { is_expected.to have_many(:recipes).dependent(:destroy) }
    it { is_expected.to have_many(:stories).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:account_users) }
  end
end
