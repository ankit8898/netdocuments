module Netdocuments
  class Configuration

    attr_accessor :cabinet_id,:client_secret,:refresh_token,:log_path,:folder_path_id,
      :cabinet_name,:logger

    def initialize
      log_dir = create_log_dir
      @cabinet_id = 'abc'
      @client_secret = '1291271823781273712129127182378127371212912718237812737121291271823781273712'
      @refresh_token = '1291271823781273712129127182378127371212912718237812737121291271823781273712'
      @log_path = "#{log_dir}/netdocuments.log"
      @folder_path_id = '48'
      @cabinet_id = 'NG-12345'
      @cabinet_name ='Test'
      @logger = Logger.new(STDOUT)
    end

    def create_log_dir
      FileUtils.mkdir_p("#{Dir.pwd}/log").last
    end
  end
end
