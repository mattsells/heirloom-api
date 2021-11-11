# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe 'Attributes' do
    describe 'email' do
      subject { FactoryBot.create(:user, email: 'user+1@example.com') }

      it { is_expected.to validate_presence_of :email }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
      it { is_expected.to validate_length_of(:email).is_at_most(256) }
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

  describe 'Methods' do
    describe '#own_account' do
      it 'returns the account on which the user role is "owner"' do
        account = user.account_users.find_by(role: 'owner').account
        expect(user.own_account.id).to be account.id
      end
    end

    describe '#member_of?' do
      [
        [:owner, true],
        [:admin, true],
        [:standard, true]
      ].each do |params|
        it "returns #{params[1]} if the user is on the account with the role #{params[0]}" do
          account = Account.create
          AccountUser.create(account: account, user: user, role: params[0].to_s)
          expect(user.member_of?(account)).to be params[1]
        end
      end

      it 'returns false if the user is not on the account' do
        account = Account.create
        expect(user.member_of?(account)).to be false
      end
    end

    describe '#admin_of?' do
      [
        [:owner, true],
        [:admin, true],
        [:standard, false]
      ].each do |params|
        it "returns #{params[1]} if the user is on the account with the role #{params[0]}" do
          account = Account.create
          AccountUser.create(account: account, user: user, role: params[0].to_s)
          expect(user.admin_of?(account)).to be params[1]
        end
      end

      it 'returns false if the user is not on the account' do
        account = Account.create
        expect(user.admin_of?(account)).to be false
      end
    end
  end

  describe 'Lifecycle' do
    describe '#create_user_account' do
      it 'creates an account after creation if not assigned one' do
        expect { FactoryBot.create(:user) }.to change(Account, :count).by 1
      end
    end
  end
end
