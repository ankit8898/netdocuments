module Netdocuments
  class Node


    attr_reader :name,:id,:extension,:parent

    def initialize(opts = {})
      @name = opts[:name]
      @id = opts[:id]
      @extension = opts[:extension]
      @parent = opts[:parent]
    end

    def update
      $logger.info "Updating #{name} with file path as #{parent}"
      if extension == 'ndfld'
        q1  = {'customAttributes' => [{"id" => "48","value" => Netdocuments::PathFormatter.new(parent).format}]}
        Netdocuments::Folder.new(id: id).update_info({query: q1.to_json})
      else
        q1  = {'customAttributes' => [{"id" => "48","value" => Netdocuments::PathFormatter.new(parent).format}]}
        Netdocuments::Document.new(id: id).update_info({query: q1.to_json})
      end
    end
  end
end
