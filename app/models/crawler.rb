class Crawler
  include Mongoid::Document

  attr_accessible :name, :params

  field :user_id     , type: Integer
  field :name        , type: String
  field :storage_key , type: String
  field :strategy    , type: String
  field :params      , type: Hash

  validates :user_id     , presence: true
  validates :name        , presence: true
  validates :storage_key , presence: true
  validates :strategy    , presence: true

  def fetch
    klass = "CrawlStrategy::#{strategy}".classify.constantize

    data = klass.fetch params
    storage.push data
  # rescue NameError
  #   nil
  end

  def storage
    Storage.find(storage_key)
  end

  def self.notify
    self.each {|crawler|
      crawler.fetch
    }
  end
end
