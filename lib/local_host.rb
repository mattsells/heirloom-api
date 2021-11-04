# frozen_string_literal: true

module LocalHost
  module FileMethods
    def url(**options)
      path = super(**options)

      Rails.env.development? ? ENV['LOCAL_ASSET_HOST'] + path : path
    end
  end
end
