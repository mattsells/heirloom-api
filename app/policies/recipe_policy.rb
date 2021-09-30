# frozen_string_literal: true

class RecipePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # For now only pull recipes on any of the user's accounts
      # This might change to include "public" recipes from other accounts
      scope.where(account_id: user.accounts.select(:id))
    end
  end

  def index?
    true
  end

  def show?
    user.member_of? record.account
  end

  def create?
    user.member_of? record.account
  end

  def update?
    user.member_of? record.account
  end

  def destroy?
    user.member_of? record.account
  end
end
