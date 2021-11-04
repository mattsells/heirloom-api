module LocalHost
	module FileMethods
		def url(**options)
			path = super(**options)

			return Rails.env.development? ? ENV['LOCAL_ASSET_HOST'] + path : path
		end
	end
end
