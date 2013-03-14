class Source < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name

  def storage
    Storage.open(storage_key)
  end
end






