# frozen_string_literal: true

module V1
  class ApiController < ApplicationController
    include Pundit
    include Respondable
    include Requestable

    before_action :authenticate_user!

    after_action :verify_authorized

    rescue_from ActiveRecord::RecordInvalid, with: :invalid_params
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def invalid_params(error)
      render error(:bad_request, error.record)
    end

    def user_not_authorized
      render error(:forbidden, I18n.t('errors.unauthorized'))
    end
  end
end
