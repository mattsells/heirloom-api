# frozen_string_literal: true

module V1
  class RegistrationsController < Devise::RegistrationsController
    include Respondable

    respond_to :json
  end
end
