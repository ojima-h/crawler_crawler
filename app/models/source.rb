class Source < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name

  def storage
    Storage.find(storage_key)
  rescue Mongoid::Errors::DocumentNotFound
    raise Storage::ErrNotFound
  end
end






