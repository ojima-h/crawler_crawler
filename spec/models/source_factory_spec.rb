require 'spec_helper'

describe SourceFactory do
  before :each do
    @user = FactoryGirl.create :user
  end

  it 'produce Source and Storage and Crawler' do
    source = SourceFactory.create(name: 'test',
                                  user: @user,
                                  crawler_strategy: 'Test',
                                  dummy_param: 'dummy')

    source.should be_a_kind_of Source
    source.storage.should be_a_kind_of Storage

    key = source.storage.key
    Crawler.where(storage_key: key).count.should be >= 1
  end
end

