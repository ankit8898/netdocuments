module Netdocuments
  class Configuration

    attr_accessor :cabinet_id,:client_secret,:refresh_token,:log_path,:folder_path_id

    def initialize
      log_dir = create_log_dir
      @cabinet_id = 'abc'
      @client_secret = 'xxxxx'
      @refresh_token = '1291271823781273712'
      @log_path = "#{log_dir}/netdocuments.log"
      @folder_path_id = '48'
    end

    def create_log_dir
      FileUtils.mkdir_p("#{Dir.pwd}/log").last
    end
  end
end
