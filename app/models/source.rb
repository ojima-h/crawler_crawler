class Source < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name

  before_validation do |source|
    storage = Storage.create
    source.storage_key = storage.key
  end

  def storage
    @storage ||= Storage.find(storage_key)
  rescue Mongoid::Errors::DocumentNotFound
    raise Storage::ErrNotFound
  end
end






