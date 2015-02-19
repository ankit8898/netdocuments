module NetDocument
	class Folder < Base

		attr_reader :id,:name,:query,:parent

		def initialize(opts = {})
			super
			@id = opts[:id] if opts[:id]
			@name = opts[:name] if opts[:name]
			@query = opts[:query] if opts[:query]
			@parent = opts[:parent] if opts[:parent]
		end


		def create
			# response = HTTParty.post(@end_point + '/v1/Folder',
			# 						 :body => {name: "Verma",parent: '4847-1782-9154',cabinet: @cabinet_id},
			# 						 :headers => @headers)
			response = post(url: '/v1/Folder',body: {name: @name, parent: @parent,cabinet: @cabinet_id})
			ap response
			ap "The response was: #{response.code}"
		end

		def profile
		end

		def folder_content
			response = get(url: "/v1/Folder/#{@id}",query: {'$select' => "standardAttributes"})
			response["ndList"]["standardList"].nil? ? [] : response["ndList"]["standardList"]["ndProfile.DocumentStat"]
		end
	end
end
