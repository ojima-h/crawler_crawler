module Storage
  def self.open(key, type: 'File')
    "Storage::#{type}".constantize.new(key)
  end

  def self.create(type: 'File')
    "Storage::#{type}".constantize.create
  end

  class ErrNotFound < StandardError; end
end
