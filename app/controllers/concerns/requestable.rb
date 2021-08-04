# frozen_string_literal: true

module Requestable
  extend ActiveSupport::Concern

	def on(*filters)
		params.slice(*filters)
	end
end
