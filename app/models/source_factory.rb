class SourceFactory
  class << self
    def create(name: nil, user: nil, crawler_strategy: 'None', **params)
      storage = Storage.create

      source = Source.create(name: name) {|s|
        s.user_id = user.id
        s.storage_key = storage.key
      }

      crawler = Crawler.create(name: name, params: params) {|c|
        c.user_id     = user.id
        c.strategy    = crawler_strategy
        c.storage_key = storage.key
      }

      source
    end
  end
end
