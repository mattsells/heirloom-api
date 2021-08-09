# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    field :email
  end

  view :extended do
    include_view :normal
  end
end
