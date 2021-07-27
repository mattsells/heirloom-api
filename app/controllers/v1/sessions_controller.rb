# frozen_string_literal: true

module V1
  class SessionsController < Devise::SessionsController
    include Respondable
  end
end
