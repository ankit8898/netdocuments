module Netdocuments
  class Document < Base

    attr_reader :id,:name

    def initialize(opts = {})
      validate_config!
      @id     = opts[:id] if opts[:id]
      @name   = opts[:name] if opts[:name]
      @query  = opts[:query] if opts[:query]
      @parent = opts[:parent] if opts[:parent]
    end


    def info
      get(url: "/v1/Document/#{@id}/info",headers: headers)
    end

    def update_info(opts = {})
      put(url: "/v1/Document/#{@id}/info",
          query: opts[:query],
          headers: headers.merge({'Content-Type' => 'application/json'}))
    end


    def headers
      {'Authorization' => "Bearer #{client.access_token.token}"}
    end
  end
end
