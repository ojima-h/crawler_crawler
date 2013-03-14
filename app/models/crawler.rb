class Crawler
  include Mongoid::Document

  field :user_id  , type: Integer
  field :name     , type: String
  field :key      , type: String

  field :strategy , type: String
  field :params   , type: Hash

  validates :user_id  , presence: true
  validates :name     , presence: true, uniqueness: true
  validates :key      , presence: true
  validates :strategy , presence: true

  def fetch
    klass = "CrawlStrategy::#{strategy}".classify.constantize
    klass.fetch **params
  rescue NameError
    nil
  end
end
