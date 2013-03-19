require 'date'

class Storage
  include Mongoid::Document
  include Enumerable

  embeds_many :entities

  delegate :count, to: :entities

  def each
    entities.reverse_each {|d| yield d }
  end

  def push(item)
    now = DateTime.now.to_s

    entities.create(contents: item, created_at: now)
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
