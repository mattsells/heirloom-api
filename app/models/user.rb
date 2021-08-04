# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :account_users, dependent: :destroy

  has_many :accounts, through: :account_users

  def own_account
    account_users.find_by(role: 'owner').account
  end

  def member_of?(account)
    AccountUser.find_by(account: account, user: self).present?
  end

  def admin_of?(account)
    AccountUser.find_by(account: account, role: admin_roles, user: self).present?
  end

  after_create :create_user_account

  private

  def create_user_account
    User.transaction do
      account = Account.new

      account_user = AccountUser.new(
        account: account,
        role: 'owner',
        user: self
      )

      account_user.save
    end
  end

  def admin_roles
    %w[admin owner]
  end
end
