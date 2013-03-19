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
    p = params[:source].symbolize_keys
    attributes = p.slice(:name, :crawler_strategy)
    attributes[:user] = current_user

    if p.has_key?(:params) and p[:params].has_key?(attributes[:crawler_strategy])
      attributes[:params] = p[:params][attributes[:crawler_strategy]]
    end

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
    p = params[:source].symbolize_keys
    @source = SourceFactory.find(params[:id])
    attributes = p.slice(:name, :crawler_strategy)

    if p.has_key?(:params) and p[:params].has_key?(attributes[:crawler_strategy])
      attributes[:params] = p[:params][attributes[:crawler_strategy]]
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
