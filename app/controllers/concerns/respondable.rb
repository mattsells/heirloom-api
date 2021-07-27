# frozen_string_literal: true

module Respondable
  extend ActiveSupport::Concern

  included do
    respond_to :json
  end

  def respond_with(resource, *_config)
    if resource.persisted?
      render json: ::UserBlueprint.render(resource)
    else
      render json: render_error(400, resource)
    end
  end

  def render_error(status, resource)
    error = if resource.respond_to? :errors
              resource.errors.full_messages.first
            elsif resource.is_a? Array
              resource.first
            else
              resource
            end

    {
      status: status,
      error: error
    }
  end
end
