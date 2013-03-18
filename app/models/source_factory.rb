require 'active_model'

class SourceFactory
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :user, :name, :crawler_strategy, :params
  attr_reader   :errors, :id, :source, :crawler, :storage

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
        @new_record = false
      end
      source
    end
  end

  def initialize(name: nil, crawler_strategy: 'None', params: {})
    @name = name
    @crawler_strategy = crawler_strategy
    @params = params

    @errors = ActiveModel::Errors.new(self)
    @new_record = true
    @id = nil
  end

  def new_record?
    @new_record
  end

  def save
    new_record? ? create : update
  end

  def save!
    save or raise ActiveRecord::RecordInvalid
  end

  def persisted?
    ! @new_record
  end

  def update_attributes(name: nil, params: nil)
    self.name   = name   if name
    self.params = params if params

    self.save
  end

  private
  def update
    if not self.name == @source.name
      @source.name  = name
      @crawler.name = name
      @source.save and @crawler.save
    end
  end

  def create
    @storage ||= Storage.create

    @crawler ||= Crawler.create!(name: @name, params: params) {|c|
      c.user_id     = @user.id
      c.strategy    = @crawler_strategy
      c.storage_key = @storage.key
    }

    @source ||= Source.create!(name: @name) {|s|
      s.user_id     = @user.id
      s.storage_key = @storage.key
    }

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
