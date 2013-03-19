require 'date'

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
    now = DateTime.now.to_s

    data.push({contents: item, created_at: now})
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
