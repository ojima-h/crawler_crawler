require 'spec_helper'

describe SourceFactory do
  before :each do
    @user = FactoryGirl.create :user
  end

  describe '.create' do
    it 'produce Source and Storage and Crawler' do
      source = SourceFactory.create(name: 'test',
                                    user: @user,
                                    crawler_strategy: 'Test',
                                    params: {name: 'dummy'})

      source.should be_a_kind_of Source
      source.storage.should be_a_kind_of Storage

      key = source.storage.key
      Crawler.where(storage_key: key).count.should be >= 1
    end
  end

  describe '#new' do
    it 'respond to user and name' do
      source = SourceFactory.new
      %i[user name].all? do |method|
        source.should respond_to method
      end
    end
  end
  describe '#save' do
    it 'persist data' do
      source = SourceFactory.new(name: 'test')
      source.user = @user
      source.save.should be_true

      Source.where(name: 'test').count.should >= 1
    end

    it 'does not persist if not valid' do
      source = SourceFactory.new(name: '')
      source.user = @user
      source.save.should be_false
    end
  end

  describe '#persisted?' do
    it 'returns true if source, crawler, etc is saved' do
      source = SourceFactory.new(name: 'test')
      source.user = @user

      source.persisted?.should be_false

      source.save

      source.persisted?.should be_true
    end
  end

  describe 'naming' do
    it 'resolves model name' do
      # SourceFactory.singular.should eq 'source'
      # SourceFactory.plural.should eq 'source'
      SourceFactory.model_name.should eq 'Source'
    end
  end

  describe '.find' do
    it 'find source' do
      s = FactoryGirl.create(:source_factory)

      source = SourceFactory.find(s.id)

      source.should be_true
      source.name.should eq s.name
    end
  end
end
