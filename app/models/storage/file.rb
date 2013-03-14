require 'json'
require 'entity'

module Storage
  class File
    include Enumerable
    FilesDir = ::File.expand_path('./db/files')

    attr_reader :key

    def self.create
      t = Time.now
      key = t.to_i.to_s + t.usec.to_s

      open(source_file_path(key), 'w') do |f|
        f.write <<EOF
[
]
EOF
      end

      new(key)
    end

    def initialize(key)
      @key = key

      path = self.class.source_file_path(key)

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

    private
    def self.source_file_path(key)
      ::File.expand_path("#{Rails.env}_#{key}.json", FilesDir);
    end
  end
end
