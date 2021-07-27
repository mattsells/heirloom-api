# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Attributes' do
    describe 'email' do
      subject { FactoryBot.create(:user, email: 'user+1@example.com') }

      it { is_expected.to validate_presence_of :email }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    end

    describe 'password' do
      it { is_expected.to validate_presence_of :password }
      it { is_expected.to validate_confirmation_of :password }
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:account_users).dependent(:destroy) }
    it { is_expected.to have_many(:accounts) }
  end
end
