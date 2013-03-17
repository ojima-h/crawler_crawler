require 'active_model'

class SourceFactory
  extend ActiveModel::Naming

  attr_accessor :user, :name, :crawler_strategy, :params
  attr_reader   :errors, :id

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
        @id = id
        @source = Source.find(@id)
        @storage = Storage.find(@source.storage_key)
        @crawler = Crawler.where(storage_key: @storage.key).first

        @name = @source.name
        @crawler_strategy = @crawler.strategy
        @params = @crawler.params
        @persist = true
      end
      source
    end
  end

  def initialize(name: nil, crawler_strategy: 'None', params: {})
    @name = name
    @crawler_strategy = crawler_strategy
    @params = params

    @errors = ActiveModel::Errors.new(self)
    @persist = false
    @id = nil
  end

  def save
    storage = Storage.create

    source = Source.new(name: @name) {|s|
      s.user_id = @user.id
      s.storage_key = storage.key
    }

    crawler = Crawler.new(name: @name, params: params) {|c|
      c.user_id     = @user.id
      c.strategy    = @crawler_strategy
      c.storage_key = storage.key
    }

    unless source.valid? and crawler.valid?
      [source, crawler].each do |obj|
        obj.errors.each do |k, v|
          errors.add k, v
        end
      end

      storage.destroy
      return nil
    end

    source.save  validate: false
    crawler.save validate: false

    @persist = true
    @id = source.id

    return source
  end

  def save!
    raise ActiveRecord::RecordInvalid unless save
  end

  def persisted?
    @persist
  end
end
