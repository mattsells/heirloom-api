# frozen_string_literal: true

module Respondable
  extend ActiveSupport::Concern

  def respond_with(resource, **config)
    if resource.persisted?
      render json: ::UserBlueprint.render(resource, blueprint_view), status: config[:status] || :ok
    else
      render error(:bad_request, resource)
    end
  end

  # On destroy method on user sign out
  def respond_to_on_destroy
    render success(I18n.t('session.signed_out'))
  end

  def success(message, status = :ok)
    {
      json: {
        status: error_code_from_status(status),
        message: message
      },
      status: status
    }
  end

  def error(status, resource)
    error = if resource.respond_to? :errors
              resource.errors.full_messages.first
            elsif resource.is_a? Array
              resource.first
            else
              resource
            end

    {
      json: {
        status: error_code_from_status(status),
        error: error
      },
      status: status
    }
  end

  def error_code_from_status(status)
    Rack::Utils::HTTP_STATUS_CODES[status]
  end

  def blueprint_view
    is_extended = ActiveModel::Type::Boolean.new.cast(params[:extended])

    if is_extended
      {
        view: :extended
      }
    else
      {}
    end
  end
end
