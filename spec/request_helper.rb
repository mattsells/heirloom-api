# frozen_string_literal: true

require 'devise/jwt/test_helpers'

module RequestHelper
  def sign_in(user)
    headers = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end

  def body_of(response, key = nil)
    body = JSON.parse(response.body)

    body = body[key.to_s] if key

    return body.deep_symbolize_keys if body.is_a?(Hash)

    body.map(&:deep_symbolize_keys)
  end

  def ids_of(response, key = nil)
    body_of(response, key).pluck(:id)
  end

  def id_of(response)
    body_of(response)[:id]
  end
end
