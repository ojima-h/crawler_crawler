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
    name  = params[:source][:name]

    if source = SourceFactory.create(name: name, user: current_user)
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

    if @source.update_attributes(params[:source].slice(:name))
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
