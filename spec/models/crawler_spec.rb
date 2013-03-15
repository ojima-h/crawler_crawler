require 'spec_helper'

describe Crawler do
  it 'instanciate' do
    crawler = FactoryGirl.create :crawler
  end

  describe '#fetch' do
    before :each do
      @user = FactoryGirl.create :user
      @source = SourcesHelper::Factory.create user: @user, params: {p: 1, q: 2}
    end

    it 'delegate to strategy module' do
      crawler = @source.crawler

      CrawlStrategy::Test.should_receive(:fetch).with('p' => 1, 'q' => 2)
      crawler.fetch
    end

    it 'stores fetched data to storage' do
      crawler = @source.crawler

      c = Storage.find(crawler.storage_key).data.count
      crawler.fetch
      Storage.find(crawler.storage_key).data.count.should eq (c+1)
    end
  end
end
