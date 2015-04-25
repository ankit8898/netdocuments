module Netdocuments
  class Cabinet < Base

    attr_reader :id

    def initialize(opts = {})
      validate_config!
      @id = opts[:id] if opts[:id]
    end


    def find_folder_tree_and_update_file_path
      Netdocuments.logger.info "Starting: find_folder_tree_and_update_file_path"
      subfolders_count = 0
      Parallel.map(folders,in_threads: 50) do |folder|
        subfolders = folder.subfolders
        Netdocuments.logger.info "Collected: #{subfolders.count} subfolders in #{folder.name}"
        subfolders_count += subfolders.count
        Parallel.map(subfolders,in_threads: 75){|node| node.update }
      end
      subfolders_count
    end

    def folder_tree
      folders.collect {|folder| folder.subfolders}
    end

    def folders
      Netdocuments.logger.info "Fetching folders..."
      response = get(url: "/v1/Cabinet/#{@id}/folders",
                     query: {'$select' => "standardAttributes"},
                     headers: headers)
      response["ndList"]["standardList"]["ndProfile.DocumentStat"].collect {|i| Netdocuments::Folder.new(id: i['id'],name: i['name'])}
    end


    def info
      get(url: "/v1/Cabinet/#{@id}/info",headers: headers)
    end

    def headers
      {'Authorization' => "Bearer #{client.access_token.token}"}
    end
  end
end
