require 'spec_helper'

describe SourcesController do
  before :each do
    @user = FactoryGirl.create(:user)
    @user_source = FactoryGirl.create(:user_source, user_id: @user.id)
    session[:user_id] = @user.id
  end

  describe '#index' do
    it 'get success' do
      get 'index'
      response.should be_success
    end
    it "assigns user's all sources" do
      get 'index'
      assigns(:user_sources).count.should eq @user.user_sources.count
    end
  end

  describe '#show' do
    it 'get success' do
      get 'show', id: @user_source.id
      response.should be_success
    end
    it "assigns user's source" do
      get 'show', id: @user_source.id
      assigns(:user_source).should eq UserSource.find(@user_source.id)
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
      post 'create', :user_source => { name: 'test_new', source_class: 'File' }

      new_user_source = UserSource.where(name: 'test_new').first

      new_user_source.should_not be_nil
      response.should redirect_to new_user_source
    end
  end

  describe '#edit' do
    it 'get success' do
      get 'edit', id: @user_source.id
      response.should be_success
    end
    it "assigns user's source" do
      get 'edit', id: @user_source.id
      assigns(:user_source).should eq UserSource.find(@user_source.id)
    end
  end

  describe '#update' do
    it 'redirect when success' do
      put 'update', :id => @user_source.id,
                    :user_source => { :name => 'test_mod', source_class: 'File' }
      response.should redirect_to @user_source
      @user_source = UserSource.find(@user_source.id)
      @user_source.name.should eq 'test_mod'
    end
  end

  describe '#destroy' do
    it 'redirect when success' do
      user_source = FactoryGirl.create(:user_source, name: 'test_del', user: @user)
      id = user_source.id

      delete 'destroy', :id => user_source.id
      response.should redirect_to '/'

      expect { UserSource.find(id) }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
