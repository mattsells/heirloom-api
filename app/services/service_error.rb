# frozen_string_literal: true

class ServiceError < StandardError
  attr_accessor :messages

  def initialize(message)
    super

    @messages = message.is_a?(Array) ? message : [message]
  end
end
