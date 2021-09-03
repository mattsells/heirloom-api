# frozen_string_literal: true

class AccountUserBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :account_id, :role, :user_id
  end

  view :extended do
    include_view :normal
    association :account, blueprint: AccountBlueprint
    association :user, blueprint: UserBlueprint
  end
end
