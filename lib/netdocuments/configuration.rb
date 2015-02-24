module Netdocuments
  class Configuration

    attr_accessor :cabinet_id,:client_secret,:refresh_token,:log_path,:folder_path_id

    def initialize
      @cabinet_id = 'abc'
      @client_secret = 'xxxxx'
      @refresh_token = '1291271823781273712'
      @log_path = "#{Dir.pwd}/log/netdocuments.log"
      @folder_path_id = '48'
    end
  end
end
