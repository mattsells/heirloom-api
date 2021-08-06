# frozen_string_literal: true

class ServiceError < StandardError
  attr_accessor :messages, :status

  def initialize(status, message)
    super

    @messages = message.is_a?(Array) ? message : [message]
    @status = status
  end
end
