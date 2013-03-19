require 'active_model'

class SourceFactory
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :errors, :id, :source, :crawler, :storage

  class << self
    def create(name: nil, user: nil, crawler_strategy: 'None', params: {})
      source = new(name: name, crawler_strategy: crawler_strategy, params: params)
      source.user = user
      source.save
    end
    def model_name
      ActiveModel::Name.new Source
    end

    def find(id)
      source = new
      source.instance_eval do |obj|
        @source  = Source.find  (id)
        @storage = Storage.find (@source.storage_key)
        @crawler = Crawler.where(storage_key: @storage.key).first

        @id = id
        @new_record = false
      end
      source
    end
  end

  def initialize(name: nil, crawler_strategy: 'None', params: {})
    @source  = Source.new(name: name)
    @storage = Storage.new
    @crawler = Crawler.new(name: name, params: params)

    @crawler.strategy = crawler_strategy

    @errors = ActiveModel::Errors.new(self)
    @new_record = true
    @id = nil
  end

  #
  # accessors
  #
  def name
    @source.name
  end
  def name=(n)
    @source.name = n
    @crawler.name = n
  end
  def user
    @source.user
  end
  def user=(u)
    @source.user = u
    @crawler.user_id = u.id
  end
  def crawler_strategy
    @crawler.strategy
  end
  def crawler_strategy=(s)
    @crawler.strategy = s
  end
  def params
    @crawler.params
  end
  def params=(p)
    @crawler.params = p
  end

  def new_record?
    @new_record
  end

  def save
    if new_record?
      create
    else
      @crawler.save
      @source.save
    end
  end

  def save!
    save or raise ActiveRecord::RecordInvalid
  end

  def persisted?
    ! (@new_record || @destroyed)
  end

  def destroy
    @storage.destroy if @storage
    @crawler.destroy if @crawler
    @source.destroy  if @source

    @destroyed = true

    self
  end

  def attributes
    { name:             self.name,
      crawler_strategy: self.crawler_strategy,
      params:           self.params,
    }
  end

  def update_attributes(attributes)
    self.name   = attributes[:name]   if attributes.has_key? :name
    self.crawler_strategy   = attributes[:crawler_strategy]   if attributes.has_key? :crawler_strategy
    self.params = attributes[:params] if attributes.has_key? :params

    self.save
  end

  private
  def update
    @source.save and @crawler.save
  end

  def create
    @storage.save!

    @crawler.storage_key = @storage.key
    @crawler.save!

    @source.storage_key = @storage.key
    @source.save!

    @new_record = false
    @id      = @source.id

    @source
  rescue ActiveRecord::RecordInvalid, Mongoid::Errors::Validations
    @storage.destroy if @storage
    @crawler.destroy if @crawler
    @source.destroy  if @source
    @storage = @crawler = @source = nil

    false
  end
end
