require 'googleajax'

module CrawlStrategy
  class Google
    GoogleAjax.referer = 'localhost'

    def fetch(**params)
      keyword = params[:keyword]

      GoogleAjax::Search.web(keyword)
    end

    def self.params_type
      {keyword: :string}
    end

    def self.to_param
      'Google'
    end
  end
end
