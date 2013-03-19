require 'spec_helper'

describe Crawler do
  it 'instanciate' do
    crawler = FactoryGirl.create :crawler
  end

  describe '#fetch' do
    before :each do
      @source = FactoryGirl.create(:source_factory)
    end

    it 'delegate to strategy module' do
      crawler = @source.crawler

      CrawlStrategy::Test.should_receive(:fetch).with(:p => 1, :q => 2)
      crawler.fetch
    end

    it 'stores fetched data to storage' do
      crawler = @source.crawler

      expect { crawler.fetch; @source.storage.reload }.to change(@source.storage, :count).by(1)
    end

    it 'does not push if no data fetched' do
      source = FactoryGirl.create(:source_factory, crawler_strategy: 'None')

      expect { source.crawler.fetch; source.storage.reload }.not_to change(source.storage, :count)
    end
  end

  describe '#params_type' do
    before :each do
      @source = FactoryGirl.create(:source_factory)
    end

    it 'returns params type info' do
      @source.crawler.should respond_to :params_type
      @source.crawler.params_type.should eq({p: :string, q: :string})
    end
  end
end
