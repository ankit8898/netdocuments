module Netdocuments
  class Folder < Base

    attr_reader :id,:name,:query,:parent

    def initialize(opts = {})
      super
      @id     = opts[:id] if opts[:id]
      @name   = opts[:name] if opts[:name]
      @query  = opts[:query] if opts[:query]
      @parent = opts[:parent] if opts[:parent]
    end


    def create
      post(url: '/v1/Folder',
           body: {name: @name, parent: @parent,cabinet: @cabinet_id})
    end

    def info
      get(url: "/v1/Folder/#{@id}/info")
    end

    def folder_content
      begin
        response = get(url: "/v1/Folder/#{id}",query: {'$select' => "standardAttributes"})
        response["ndList"]["standardList"].nil? ? [] : [response["ndList"]["standardList"]["ndProfile.DocumentStat"]].flatten
      rescue Exception => e
        $logger.error "----------#{id}-----#{e.message}"
        []
      end

    end


    def folder_extraction(opts = {})
      contents = Netdocuments::Folder.new({id: opts[:id]}).folder_content
      col = contents.collect do |folder|
        obj = Netdocuments::Node.new(name: folder['name'],
                                     id: folder['id'],
                                     extension: folder['extension'],
                                     parent: opts[:parent])
        obj
      end
    end


    def subfolders
      $logger.info "Starting subfolder collection for: #{name}"
      nodes = []
      ids = [{id: @id,parent: "WorkspaceResetTest/#{name}"}]
      loop do
        r =  ids.collect do |id|
          folder_extraction(id)
        end.flatten!
        nodes << r
        folders = r.select {|i| i.extension == 'ndfld'}
        ids = folders.collect {|o| {id: o.id,parent: "#{o.parent}/#{o.name}"}}
        break if ids.count == 0
      end
      nodes.flatten!
    end


    def ancestry
      response = get(url: "/v1/Folder/#{@id}/ancestry")
    end

    def update_info(opts = {})
      response = put(url: "/v1/Folder/#{@id}/info",
                     query: opts[:query],
                     headers: {'Content-Type' => 'application/json'})
    end
  end
end
