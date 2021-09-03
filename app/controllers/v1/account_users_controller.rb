# frozen_string_literal: true

module V1
  class AccountUsersController < ApiController
    def index
      authorize AccountUser

      records = policy_scope(AccountUser)
                .extended_includes(params, :account, :user)
                .sift(on(:user))

      render json: ::AccountUserBlueprint.render(records, blueprint_view)
    end
  end
end
