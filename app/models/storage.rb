module Storage
  def self.open(key, type: 'File')
    supported_type = %w[ File ]
    raise "type #{type} is not supported" unless supported_type.include? type

    klass = eval("Storage::#{type}")

    klass.new(key)
  end

  def self.create(key, type: 'File')
    supported_type = %w[ File ]
    raise "type #{type} is not supported" unless supported_type.include? type

    klass = eval("Storage::#{type}")

    klass.create(key)
  end

  class ErrNotFound < StandardError; end
end
