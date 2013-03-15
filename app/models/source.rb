class Source < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name

  def storage
    @storage ||= Storage.find(storage_key)
  rescue Mongoid::Errors::DocumentNotFound
    raise Storage::ErrNotFound
  end

  def crawler
    Crawler.where(storage_key: storage_key).first
  end
end








