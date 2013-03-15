require 'googleajax'

module CrawlerStrategy
  class Google
    GoogleAjax.referer = 'localhost'

    def fetch(**params)
      keyword = params[:keyword]

      GoogleAjax::Search.web(keyword)
    end
  end
end
