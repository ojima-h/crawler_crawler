require 'spec_helper'

describe Crawler do
  it 'instanciate' do
    crawler = FactoryGirl.create :crawler
  end

  describe '#fetch' do
    it 'delegate to strategy module' do
      crawler = FactoryGirl.create :crawler

      CrawlStrategy::None.should_receive(:fetch).with(p: 1, q: 2)
      crawler.fetch
    end
  end
end
