# frozen_string_literal: true

class AccountUserBlueprint < Blueprinter::Base
  identifier :id

  fields :account_id, :role, :user_id

  view :extended do
    association :account, blueprint: AccountBlueprint
    association :user, blueprint: UserBlueprint
  end
end
