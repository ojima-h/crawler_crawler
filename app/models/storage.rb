module Storage
  def self.open(key)
    Mongo.find(key)
  rescue Mongoid::Errors::DocumentNotFound
    raise ErrNotFound
  end

  def self.create
    Mongo.create(data: [])
  end

  def self.exists?(key)
    Mongo.find(key)
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end

  class ErrNotFound < StandardError; end
end
