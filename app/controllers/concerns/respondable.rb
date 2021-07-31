# frozen_string_literal: true

module Respondable
  extend ActiveSupport::Concern

  def respond_with(resource, **config)
    if resource.persisted?
      render json: ::UserBlueprint.render(resource), status: config[:status] || :ok
    else
      render error(:bad_request, resource)
    end
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
        status: Rack::Utils::HTTP_STATUS_CODES[status],
        error: error
      },
      status: status
    }
  end
end
