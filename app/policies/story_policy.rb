# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(account_id: user.accounts.pluck(:id))
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
