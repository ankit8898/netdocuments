module Netdocuments
  class Node < Base


    attr_reader :name,:id,:extension,:parent,:folder_path

    def initialize(opts = {})
      validate_config!
      @name = opts[:name]
      @id = opts[:id]
      @extension = opts[:extension]
      @parent = opts[:parent]
      @folder_path = opts[:folder_path]
    end

    def update
      # Netdocuments.logger.info "Updating #{name} with file path as #{folder_path}"
      if extension == 'ndfld'
        q1  = {'customAttributes' => [{"id" => Netdocuments.configuration.folder_path_id,"value" => Netdocuments::PathFormatter.new(folder_path).format}]}
        Netdocuments::Folder.new(id: id).update_info({query: q1.to_json})
      else
        q1  = {'customAttributes' => [{"id" => Netdocuments.configuration.folder_path_id,"value" => Netdocuments::PathFormatter.new(folder_path).format}]}
        Netdocuments::Document.new(id: id).update_info({query: q1.to_json})
      end
    end
  end
end
