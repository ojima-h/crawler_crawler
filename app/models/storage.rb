module Storage
  def self.open(key, type: 'File')
    "Storage::#{type}".constantize.open(key)
  end

  def self.create(type: 'File')
    "Storage::#{type}".constantize.create
  end

  def self.exists?(key, type: 'File')
    "Storage::#{type}".constantize.exists?(key)
  end

  class ErrNotFound < StandardError; end
end
