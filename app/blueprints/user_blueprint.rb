# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  field :email

  view :extended do
  end
end
