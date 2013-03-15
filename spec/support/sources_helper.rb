module SourcesHelper
  class Factory
    def self.create(user: nil, **params)
      name     = params[:name]     || 'test'
      strategy = params[:strategy] || 'Test'
      _params  = params[:params]   || {}

      SourceFactory.create(user:             user,
                           name:             name,
                           crawler_strategy: strategy,
                           **_params)
    end
  end
end

