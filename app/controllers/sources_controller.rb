class SourcesController < ApplicationController
  def index
    @sources = current_user.sources
  end

  def show
    @source = Source.find(params[:id])
  end

  def new
    @source = Source.new
  end

  def create
    source = Source.new(params[:source].slice(:name, :klass))
    source.user = current_user
    source.save

    redirect_to source
  end

  def edit
    @source = Source.find(params[:id])
  end

  def update
    @source = Source.find(params[:id])
    @source.update_attributes(params[:source].slice(:name, :klass))

    redirect_to @source
  end

  def destroy
    @source = Source.find(params[:id])
    @source.destroy

    redirect_to '/'
  end
end
