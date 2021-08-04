# frozen_string_literal: true

module Requestable
  extend ActiveSupport::Concern

  def on(*filters)
    (params['filters'] || {}).slice(*filters)
  end
end
