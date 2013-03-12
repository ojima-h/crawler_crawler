require 'json'
require 'source'

module Sources
  class File
    include Enumerable
    FilesDir = ::File.expand_path('./db/files')

    def initialize(path)
      path = ::File.expand_path(path, FilesDir);

      @data = open(path, 'r') do |f|
        JSON.parse( f.read )
      end
    end

    def each
      @data.each do |entry|
        yield Source.new(entry)
      end
    end
  end
end
