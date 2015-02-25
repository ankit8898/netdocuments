module Netdocuments
  class Folder < Base

    attr_reader :id,:name,:query,:parent,:cabinet_id,:client

    def initialize(client,opts = {})
      @client = client
      validate_config!
      @headers = {'Authorization' => "Bearer #{@client.access_token.token}"}
      @id      = opts[:id]     if opts[:id]
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
           headers: @headers)
    end

    def info
      get(url: "/v1/Folder/#{@id}/info",
          headers: @headers)
    end

    def folder_content
      begin
        response = get(url: "/v1/Folder/#{id}",
                       query: {'$select' => 'standardAttributes'},
                       headers: @headers)
        response["ndList"]["standardList"].nil? ? [] : [response["ndList"]["standardList"]["ndProfile.DocumentStat"]].flatten
      rescue Exception => e
        logger.error "********* #{id} ********* #{e.message}"
        logger.error e.backtrace.join("\n")
        []
      end

    end


    def folder_extraction(opts = {})
      contents = Netdocuments::Folder.new(@client, {id: opts[:id]}).folder_content.compact
      col = contents.collect do |folder|
        obj = Netdocuments::Node.new(@client,name: folder['name'],
                                     id: folder['id'],
                                     extension: folder['extension'],
                                     parent: opts[:parent],
                                     folder_path: "#{opts[:parent]}/#{folder['name']}")
        obj
      end
    end


    def subfolders
      logger.info "Starting subfolders collection for: #{name}"
      nodes = []
      ids = [{id: @id, parent: "WorkspaceResetTest/#{name}"}]
      loop do
        sleep 0.5
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
      response = get(url: "/v1/Folder/#{@id}/ancestry",headers: @headers)
    end

    def update_info(opts = {})
      response = put(url: "/v1/Folder/#{@id}/info",
                     query: opts[:query],
                     headers: @headers.merge({'Content-Type' => 'application/json'}))
    end


  end
end
