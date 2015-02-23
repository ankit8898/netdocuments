module Netdocuments
  class Base

    END_POINT = 'https://api.vault.netvoyage.com'

    def post(opts = {})
      HTTParty.post(END_POINT + opts[:url],
                    :body => opts[:body],
                    :headers => opts[:headers])
    end


    def get(opts = {})
      HTTParty.get(END_POINT + opts[:url],
                   query: opts[:query],
                   headers: opts[:headers])
    end

    def put(opts = {})
      HTTParty.put(END_POINT + opts[:url],
                   body: opts[:query],
                   headers: opts[:headers])
    end


    def validate_config!
      $logger.info "Token is: #{@client.access_token.valid? ? 'valid' : 'invalid'} ..Last generated: #{@client.access_token.last_generated_minutes_ago} minutes ago. "
      if @client.access_token.valid?
        true
      else
        $logger.info "Fetching new token..."
        @client.get_token!
      end
    end

  end
end
