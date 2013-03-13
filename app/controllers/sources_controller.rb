class SourcesController < ApplicationController
  def index
    @user_sources = current_user.user_sources
  end

  def show
    @user_source = UserSource.find(params[:id])
  end

  def new
    @user_source = UserSource.new
  end

  def create
    user_source = UserSource.new(params[:user_source].slice(:name, :source_class))
    user_source.user = current_user
    user_source.save

    redirect_to user_source
  end

  def edit
    @user_source = UserSource.find(params[:id])
  end

  def update
    @user_source = UserSource.find(params[:id])
    @user_source.update_attributes(params[:user_source].slice(:name, :source_class))

    redirect_to @user_source
  end

  def destroy
    @user_source = UserSource.find(params[:id])
    @user_source.destroy

    redirect_to '/'
  end
end
