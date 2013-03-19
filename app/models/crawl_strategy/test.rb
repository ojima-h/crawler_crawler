module CrawlStrategy
  module Test
    def self.fetch(**params)
      "CrawlStrategy::Test#fetch is called with #{params}"
    end
    def self.params_type
      {p: :string, q: :string}
    end

    def self.to_param
      'Test'
    end
  end
end
