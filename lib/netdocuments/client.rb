module Netdocuments
  class Client

    attr_reader :refresh_token,:client_secret,:access_token


    def initialize(opts = {})
      @refresh_token = opts[:refresh_token]
      @client_secret = opts[:client_secret]
    end


    def get_token
      @access_token = Netdocuments::AccessTokenMaster.new(client_secret: @client_secret,
                                                          refresh_token: @refresh_token)
    end
  end
end
