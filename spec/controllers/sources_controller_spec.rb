require 'spec_helper'

describe SourcesController do
  include PrepareHelpers::Methods

  before :all do
    prepare_storage_file
  end
  after :all do
    File.unlink source_file_path
  end

  before :each do
    @user = FactoryGirl.create(:user)
    @source = FactoryGirl.create(:source, user_id: @user.id)
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
      assigns(:source).should eq Source.find(@source.id)
      assigns(:storage).should eq @source.storage
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

      new_source = Source.where(name: 'test_new').first

      new_source.should_not be_nil
      response.should redirect_to new_source
    end
  end

  describe '#edit' do
    it 'get success' do
      get 'edit', id: @source.id
      response.should be_success
    end
    it "assigns user's source" do
      get 'edit', id: @source.id
      assigns(:source).should eq Source.find(@source.id)
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
  end

  describe '#destroy' do
    it 'redirect when success' do
      source = FactoryGirl.create(:source, name: 'test_del', user: @user)
      id = source.id

      delete 'destroy', :id => source.id
      response.should redirect_to '/'

      expect { Source.find(id) }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
