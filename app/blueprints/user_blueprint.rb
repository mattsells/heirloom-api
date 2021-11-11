# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  field :email

  view :extended do
    identifier :id
  end
end
