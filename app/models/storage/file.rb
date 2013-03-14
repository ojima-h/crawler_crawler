require 'json'
require 'entity'

module Storage
  class File
    include Enumerable
    FilesDir = ::File.expand_path('./db/files')

    attr_reader :key

    class << self
      def open(key)
        new(key)
      end

      def create
        key = generate_key

        ::File.open(source_file_path(key), 'w') do |f|
          f.write "[\n]\n"
        end

        new(key)
      end

      def exists?(key)
        ::File.exists? source_file_path(key)
      end

      def generate_key
        t = Time.now
        t.to_i.to_s + t.usec.to_s
      end

      def source_file_path(key)
        ::File.expand_path("#{Rails.env}_#{key}.json", FilesDir);
      end
    end

    def initialize(key)
      @key = key
      @path = self.class.source_file_path(key)

      raise ErrNotFound unless ::File.exist? @path
    end

    def each
      load_data.reverse_each do |entry|
        yield Entity.new(entry)
      end
    end

    def push(item)
      data = load_data

      data.push item

      dump_data data
    end

    def ==(obj)
      obj.is_a? Storage::File and obj.key == key
    end

    def load_data
      ::File.open(@path, 'r') do |f|
        JSON.parse( f.read )
      end
    end
    def dump_data(data)
      ::File.open(@path, 'w+') do |f|
        f.write data.to_json
      end
    end
  end
end
