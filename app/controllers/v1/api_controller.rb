# frozen_string_literal: true

module V1
  class ApiController < ApplicationController
    include Pundit
    include Respondable
    include Requestable

    before_action :authenticate_user!

    after_action :verify_authorized

    rescue_from ActiveRecord::RecordInvalid,  with: :invalid_params
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from Pundit::NotAuthorizedError,   with: :user_not_authorized
    rescue_from ServiceError,                 with: :service_error

    private

    # Error response handlers

    def invalid_params(error)
      render error(:bad_request, error.record)
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
