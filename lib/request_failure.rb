# frozen_string_literal: true

class RequestFailure < Devise::FailureApp
  def respond
    self.status = 401
    self.content_type = 'json'
    self.response_body = {
      status: status,
      errors: [i18n_message]
    }.to_json
  end
end
