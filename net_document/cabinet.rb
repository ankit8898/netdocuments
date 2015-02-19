module NetDocument
	class Cabinet < Base

		attr_reader :id

		def initialize(opts = {})
			super
			@id = opts[:id] if opts[:id]
		end


		def folders
			response = get(url: "/v1/Cabinet/#{@id}/folders",query: {'$select' => "standardAttributes"})
			response["ndList"]["standardList"]["ndProfile.DocumentStat"]

		end

		def info
			get(url: "/v1/Cabinet/#{@id}/info")
		end
	end
end
