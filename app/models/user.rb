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
