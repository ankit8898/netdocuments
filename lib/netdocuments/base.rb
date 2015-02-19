module Netdocuments
  class Base

    attr_reader :access_token,:end_point,:cabinet_id
    attr_accessor :headers

    def initialize(opts = {})
      @access_token =  Netdocuments::AccessToken.get.access_token
      @end_point =  'https://api.vault.netvoyage.com'
      @cabinet_id = 'CA-EKOBPSMJ'
      @headers = {'Authorization' => "Bearer #{access_token}"}
    end


    def post(opts = {})
      response = HTTParty.post(@end_point + opts[:url],
                               :body => opts[:body],
                               :headers => @headers.merge(opts[:headers] || {}))
      response
    end


    def get(opts = {})
      ap "Processing with: #{opts}"
      response = HTTParty.get(@end_point + opts[:url],query: opts[:query],headers: @headers.merge(opts[:headers] || {}))
      response
    end
  end
end
