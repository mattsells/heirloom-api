# frozen_string_literal: true

class RecipePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # For now only pull recipes on any of the user's accounts
      # This might change to include "public" recipes from other accounts
      scope.where(account_id: user.accounts.pluck(:id))
    end
  end

  def index?
    true
  end
end
