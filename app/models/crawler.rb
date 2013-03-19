class Crawler
  class CrawlerParam < Hash
    def self.demongoize(object)
      if object.is_a? Hash
        object.symbolize_keys!
      else
        object
      end
    end
  end

  include Mongoid::Document

  attr_accessible :name, :params

  field :user_id     , type: Integer
  field :name        , type: String
  field :storage_key , type: String
  field :strategy    , type: String
  field :params      , type: CrawlerParam

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

  def params_type
    klass.params_type
  end

  def storage
    Storage.find(storage_key)
  end

  def self.notify
    self.each {|crawler|
      crawler.fetch
    }
  end

  def self.strategies
    [ CrawlStrategy::None,
      CrawlStrategy::Test,
      CrawlStrategy::Google ]
  end

  def has_strategy?(strategy)
    strategy == klass
  end

  private
  def klass
    @klass ||= "CrawlStrategy::#{strategy}".classify.constantize
  end

end


