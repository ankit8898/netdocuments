module Netdocuments
  class Base

    END_POINT = 'https://api.vault.netvoyage.com'

    def post(opts = {})
      HTTParty.post(END_POINT + opts[:url],
                    :body => opts[:body],
                    :headers => opts[:headers],
                    :timeout => 180)
    end


    def get(opts = {})
      HTTParty.get(END_POINT + opts[:url],
                   query: opts[:query],
                   headers: opts[:headers],
                   timeout: 180)
    end

    def put(opts = {})
      HTTParty.put(END_POINT + opts[:url],
                   body: opts[:query],
                   headers: opts[:headers])
    end


    def delete(opts = {})
    end


    def client
      Netdocuments::Client.instance
    end

    def validate_config!
      if client.access_token.nil?
        puts "--- Fetching first time token---"
        client.get_token
      elsif !client.access_token.valid?
        puts "--- Fetching New token ---"
        client.get_token
      end
    end
  end
end
