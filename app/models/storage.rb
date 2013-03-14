class Storage
  include Mongoid::Document
  include Enumerable

  field :data, default: []

  def each
    data.reverse_each do |d|
      yield Entity.new d
    end
  end

  def push(item)
    data.push item
    save
  end

  def key
    id.to_s
  end

  def self.has_key?(key)
    find(key)
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end

  ErrNotFound = Mongoid::Errors::DocumentNotFound
end
