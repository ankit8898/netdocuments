module Netdocuments
  class Cabinet < Base

    attr_reader :id

    def initialize(opts = {})
      super
      @id = opts[:id] if opts[:id]
    end


    def find_folder_tree_and_update_file_path
      subfolders_count = 0
      Parallel.map(folders,in_threads: 50) do |folder|
        subfolders = folder.subfolders
        subfolders_count = folder.subfolders.flatten.count
        $logger.info "Collected: #{subfolders_count}"
        Parallel.map(subfolders,in_threads: 75){|node| node.update }
      end
      subfolders_count
    end

    def folder_tree
      folders.collect {|folder| folder.subfolders}
    end

    def folders
      $logger.info "Fetching folders..."
      response = get(url: "/v1/Cabinet/#{@id}/folders",query: {'$select' => "standardAttributes"})
      response["ndList"]["standardList"]["ndProfile.DocumentStat"].collect {|i| Netdocuments::Folder.new({id: i['id'],name: i['name']})}
    end

    def update_nodes

    end

    def info
      get(url: "/v1/Cabinet/#{@id}/info")
    end
  end
end
