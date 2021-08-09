# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # Only allow users to view themself
  def show?
    user.id == record.id
  end
end
