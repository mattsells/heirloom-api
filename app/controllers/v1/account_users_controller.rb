# frozen_string_literal: true

module V1
  class AccountUsersController < ApiController
    def index
      authorize AccountUser

      records, meta = policy_scope(AccountUser)
                      .extended_includes(params, :account, :user)
                      .sift(on(:user))
                      .paginate(params)

      render json: ::AccountUserBlueprint.render(records, { **blueprint_view, root: :account_users, meta: meta })
    end
  end
end
