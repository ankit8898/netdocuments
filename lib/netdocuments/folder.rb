module Netdocuments
  class Folder < Base

    attr_reader :id,:name,:query,:parent

    def initialize(opts = {})
      validate_config!
      @id      = URI::encode(opts[:id])  if opts[:id]
      @name    = opts[:name]   if opts[:name]
      @query   = opts[:query]  if opts[:query]
      @parent  = opts[:parent] if opts[:parent]
    end

    def cabinet_id
      Netdocuments.configuration.cabinet_id
    end

    def create
      post(url: '/v1/Folder',
           body: {
             name: @name,
             parent: @parent
           },
           headers: headers)
    end

    def info
      get(url: "/v1/Folder/#{@id}/info",
          headers: headers)
    end

    def folder_content
      begin
        response = get(url: "/v1/Folder/#{id}",
                       query: {'$select' => 'standardAttributes'},
                       headers: headers)
        response["ndList"]["standardList"].nil? ? [] : [response["ndList"]["standardList"]["ndProfile.DocumentStat"]].flatten
      rescue Exception => e
        #puts "********* #{id} ********* #{e.message}"
        #puts e.backtrace.join("\n")
        []
      end

    end


    def folder_extraction(opts = {})
      contents = Netdocuments::Folder.new(id: opts[:id]).folder_content.compact
      col = contents.collect do |folder|
        obj = Netdocuments::Node.new(name: folder['name'],
                                     id: folder['id'],
                                     extension: folder['extension'],
                                     parent: opts[:parent],
                                     folder_path: "#{opts[:parent]}/#{folder['name']}")
        obj
      end
    end


    def subfolders
      Netdocuments.logger.info "Starting subfolders collection for: #{name}"
      nodes = []
      ids = [{id: @id, parent: "#{Netdocuments.configuration.cabinet_name}/#{name}"}]
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
      response = get(url: "/v1/Folder/#{@id}/ancestry",headers: headers)
    end

    def update_info(opts = {})
      response = put(url: "/v1/Folder/#{@id}/info",
                     query: opts[:query],
                     headers: headers.merge({'Content-Type' => 'application/json'}))
    end

    #udpating nodes via sidekiq worker
    def find_subfolders_and_update_nodes
      stats = {nodes_count: 0,folder_name: name}
      puts "---- Starting subfolders collection for - #{name} ---- "
      nodes = []
      ids = [{id: @id, parent: "#{Netdocuments.configuration.cabinet_name}/#{name}"}]
      loop do
        r =  ids.collect do |id|
          folder_extraction(id)
        end.flatten!
        nodes << r
        stats[:nodes_count] = stats[:nodes_count] + nodes.flatten.count
        nodes.flatten.each do |node|
          puts "---- Pushing: #{node.folder_path} in node queue ----"
          NodeWorker.perform_async(node.id,node.extension,node.folder_path)
        end
        nodes = []
        folders = r.select {|i| i.extension == 'ndfld'}
        ids = folders.collect {|o| {id: o.id,parent: "#{o.parent}/#{o.name}"}}
        break if ids.count == 0
      end
      stats
    end


    def headers
      {'Authorization' => "Bearer #{client.access_token.token}"}
    end
  end
end
