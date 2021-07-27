# frozen_string_literal: true

class ApplicationService
  attr_accessor :errors, :result

  def initialize(*_args)
    @errors = []
    @result = {}
  end

  def call
    begin
      yield
    rescue ServiceError => e
      add_to_errors(e.messages)
    end

    completed?
  end

  def completed?
    errors.empty?
  end

  def failed?
    errors.any?
  end

  private

  def add_to_errors(messages)
    errors.concat(messages)
  end

  def add_result(data)
    result.merge!(data)
  end
end
