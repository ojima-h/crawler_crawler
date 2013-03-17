module SourcesHelper
  class Factory
    def self.create(user: nil, name: 'test', strategy: 'Test', params: {})
      SourceFactory.create(user:             user,
                           name:             name,
                           crawler_strategy: strategy,
                           params:           params)
    end
  end
end

