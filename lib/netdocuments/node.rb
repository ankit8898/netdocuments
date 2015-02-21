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
      ap "Updating #{name} with file path as #{parent}"
      if extension == 'ndfld'
        q1  = {'customAttributes' => [{"id" => "48","value" => parent}]}
        Netdocuments::Folder.new(id: id).update_info({query: q1.to_json})
      else
        q1  = {'customAttributes' => [{"id" => "48","value" => parent}]}
        Netdocuments::Document.new(id: id).update_info({query: q1.to_json})
      end
      ap "Updated!"
    end
  end
end
