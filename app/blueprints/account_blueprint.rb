# frozen_string_literal: true

class AccountBlueprint < Blueprinter::Base
  identifier :id

  view :extended do
    identifier :id
  end
end
