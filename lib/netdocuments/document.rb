module Netdocuments
  class Document < Base

    def initialize(client,opts = {})
      @client = client
      validate_config!
      @headers = {'Authorization' => "Bearer #{@client.access_token.token}"}
      @id     = opts[:id] if opts[:id]
      @name   = opts[:name] if opts[:name]
      @query  = opts[:query] if opts[:query]
      @parent = opts[:parent] if opts[:parent]
    end


    def info
      get(url: "/v1/Document/#{@id}/info",headers: @headers)
    end

    def update_info(opts = {})
      put(url: "/v1/Document/#{@id}/info",
          query: opts[:query],
          headers: @headers.merge({'Content-Type' => 'application/json'}))
    end

  end
end
