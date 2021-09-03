# frozen_string_literal: true

class AccountBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
  end

	view :extended do
    include_view :normal
  end
end
