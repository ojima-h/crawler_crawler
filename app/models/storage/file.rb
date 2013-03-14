require 'json'
require 'entity'

module Storage
  class File
    include Enumerable
    FilesDir = ::File.expand_path('./db/files')

    attr_reader :key

    def initialize(key)
      @key = key

      path = ::File.expand_path(key + '.json', FilesDir);

      raise ErrNotFound unless ::File.exist? path

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

    def ==(obj)
      obj.is_a? Storage::File and obj.key == key
    end
  end
end
