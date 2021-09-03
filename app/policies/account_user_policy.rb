# frozen_string_literal: true

class AccountUserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # Scope to all account users on all accounts the user is on
      scope.where(account_id: user.accounts.select(:id))
    end
  end

  def index?
    true
  end
end
