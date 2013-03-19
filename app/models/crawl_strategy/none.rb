module CrawlStrategy
  module None
    def self.fetch(**params)
    end
    def self.params_type
      {}
    end

    def self.to_param
      'None'
    end
  end
end
