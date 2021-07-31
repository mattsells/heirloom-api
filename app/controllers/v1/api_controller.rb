# frozen_string_literal: true

module V1
  class ApiController < ApplicationController
    include Pundit
    include Respondable

    after_action :verify_authorized

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      render error(:forbidden, t('errors.unauthorized'))
    end
  end
end
