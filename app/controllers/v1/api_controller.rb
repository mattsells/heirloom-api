# frozen_string_literal: true

module V1
  class ApiController < ApplicationController
    include Pundit
    include Respondable
    include Requestable

    before_action :authenticate_user!

    after_action :verify_authorized

    # ArgumentError occurs when an enum value is not valid
    rescue_from ArgumentError,                with: :invalid_params
    rescue_from ActiveRecord::RecordInvalid,  with: :invalid_params
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from Pundit::NotAuthorizedError,   with: :user_not_authorized
    rescue_from ServiceError,                 with: :service_error

    private

    # Error response handlers

    def invalid_params(error)
      content = error.respond_to?(:record) ? error.record : error.message
      render error(:bad_request, content)
    end

    def record_not_found
      render error(:not_found, I18n.t('errors.not_found'))
    end

    def service_error(error)
      render error(error.status, error.messages)
    end

    def user_not_authorized
      render error(:forbidden, I18n.t('errors.unauthorized'))
    end
  end
end
