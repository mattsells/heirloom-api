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

  def body_of(response)
    body = JSON.parse(response.body)

    return body.deep_symbolize_keys if body.is_a?(Hash)

    body.map(&:deep_symbolize_keys)
  end

  def ids_of(response)
    body_of(response).map { |recipe| recipe[:id] }
  end

  def id_of(response)
    body_of(response)[:id]
  end

  # def image_data
  #   { 
  #     "id": "43kewit94.jpg",
  #     "storage": "cache",
  #     "metadata": { 
  #       "size": 384393,
  #       "filename": "nature.jpg",
  #       "mime_type": "image/jpeg"
  #     }
  #   }
  # end
end
