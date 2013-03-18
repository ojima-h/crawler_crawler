class SourcesController < ApplicationController
  def index
    @sources = current_user.sources
  end

  def show
    @source = SourceFactory.find(params[:id])

  rescue Storage::ErrNotFound
    redirect_to :sources, notice: 'Error occurred'
  end

  def new
    @source = SourceFactory.new
  end

  def create
    attributes = {}
    params[:source].slice(:name, :crawler_strategy).each do |k, v|
      attributes[k.to_sym] = v
    end
    attributes[:user] = current_user

    if source = SourceFactory.create(**attributes)
      redirect_to source
    else
      redirect_to :new_source, :notice => 'Failed to create source'
    end
  end

  def edit
    @source = SourceFactory.find(params[:id])
  end

  def update
    @source = SourceFactory.find(params[:id])
    attributes = {}
    params[:source].slice(:name, :crawler_strategy).each do |k, v|
      attributes[k.to_sym] = v
    end

    if @source.update_attributes(**attributes)
      redirect_to @source
    else
      redirect_to edit_source_path(@source)
    end
  end

  def destroy
    @source = SourceFactory.find(params[:id])
    @source.destroy

    redirect_to '/'
  end
end
