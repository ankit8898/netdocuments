module Netdocuments
  class AccessTokenMaster

    attr_reader :token,:grant_type,:client_secret,:url,:refresh_token

    def initialize(opts = {})
      @grant_type    = 'refresh_token'
      @url           = 'https://api.vault.netvoyage.com/v1/OAuth'
      @client_secret = opts[:client_secret]
      @refresh_token = opts[:refresh_token]
      @generated_at  = Time.now
      @validity      = 1 #this is in minutes
      @token         = get_token
    end

    def get_token
      response = HTTParty.post(@url,
                               body: {
                                 grant_type: @grant_type,
                                 refresh_token: @refresh_token
                               },
                               headers: {
                                 'Authorization' => "Basic #{@client_secret}"
                               }
                               )
      response['access_token']
    end


    def valid?
      last_generated_minutes_ago <= @validity
    end

    def last_generated_minutes_ago
      TimeDifference.between(@generated_at,Time.now).in_minutes
    end
  end
end
