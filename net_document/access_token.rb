module NetDocument
	class AccessToken

		attr_reader :access_token,:grant_type,:refresh_token,:url

		def initialize
			@grant_type = 'refresh_token'
			@url = 'https://api.vault.netvoyage.com/v1/OAuth'
			@refresh_token = '+BfZ+k7QspKVl+8Q1hSK+88x037Qwb6HkHCn3KNkrBeDdFXsG1AkGuPvhCaFUIkQu8Z/2fIanQBf4l7SdmuCiA=='
			@client_secret = 'QVAtTUFEUkxCTTM6YVFjc09FclRJYURuWlhaVndnY1N4clBXSUczTk9vYzgxVWxGV2FDNVRPV09rZVNi'
		end


		def self.get
			obj = new
			obj.get
			obj
		end

		def get
			response = HTTParty.post(@url,
									 :body => {grant_type: @grant_type,refresh_token: @refresh_token},
									 :headers => {'Authorization' => "Basic #{@client_secret}"})
			@access_token = response['access_token']
		end

	end
end
