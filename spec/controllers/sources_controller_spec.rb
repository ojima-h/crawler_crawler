require 'spec_helper'

describe SourcesController do
  prepare_storage

  before :each do
    @user = FactoryGirl.create(:user)
    @source = SourcesHelper::Factory.create(user: @user)
    session[:user_id] = @user.id
  end

  describe '#index' do
    it 'get success' do
      get 'index'
      response.should be_success
    end
    it "assigns user's all sources" do
      get 'index'
      assigns(:sources).count.should eq @user.sources.count
    end
  end

  describe '#show' do
    it 'get success' do
      get 'show', id: @source.id
      response.should be_success
    end
    it "assigns user's source" do
      get 'show', id: @source.id
      assigns(:source).name.should eq SourceFactory.find(@source.id).name
    end
  end

  describe '#new' do
    it 'get success' do
      get 'new'
      response.should be_success
    end
  end

  describe '#create' do
    it 'redirect when success' do
      post 'create', :source => { name: 'test_new' }

      response.should redirect_to Source.last

      new_source = Source.where(name: 'test_new').first
      new_source.should_not be_nil
    end
    it 'could specify crawler strategy with params' do
      post 'create', :source => { name: 'test_new', crawler_strategy: 'Test', params: {'Test' => {'p' => 4}} }

      id = Source.last.id
      new_source = SourceFactory.find(id)
      new_source.crawler_strategy.should eq "Test"
      new_source.params[:p].should eq '4'
    end
  end

  describe '#edit' do
    it 'get success' do
      get 'edit', id: @source.id
      response.should be_success
    end
    it "assigns user's source" do
      get 'edit', id: @source.id
      assigns(:source).name.should eq SourceFactory.find(@source.id).name
    end
  end

  describe '#update' do
    it 'redirect when success' do
      put 'update', :id => @source.id,
                    :source => { :name => 'test_mod' }
      response.should redirect_to @source
      @source = Source.find(@source.id)
      @source.name.should eq 'test_mod'
    end
    it 'could update crawler strategy' do
      put 'update', :id => @source.id,
                    :source => { :name => 'test_mod',
                                 :crawler_strategy => 'None' }

      @source = SourceFactory.find(@source.id)
      @source.crawler_strategy.should eq 'None'
    end
  end

  describe '#destroy' do
    it 'redirect when success' do
      source = SourcesHelper::Factory.create(name: 'test_del', user: @user)
      id = source.id

      delete 'destroy', :id => source.id
      response.should redirect_to '/'

      expect { Source.find(id) }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
