require 'json'
require 'entity'

module Storage
  class File
    include Enumerable
    FilesDir = ::File.expand_path('./db/files')

    def initialize(path)
      path = ::File.expand_path(path + '.json', FilesDir);

      @data = open(path, 'r') do |f|
        JSON.parse( f.read )
      end
    end

    def each
      @data.reverse_each do |entry|
        yield Entity.new(entry)
      end
    end

    def push
      error 'Storage::File#push is not implemented yet.'
    end
  end
end
