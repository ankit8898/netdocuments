module Netdocuments
  class PathFormatter

    attr_reader :path
    def initialize(path)
      @path = path
    end

    def format
      arr = @path.split('/')
      root_node = arr.last
      arr.pop
      arr.join(' /  ') + " / " + root_node
    end
  end
end
