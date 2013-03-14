class SourcesController < ApplicationController
  def index
    @sources = current_user.sources
  end

  def show
    @source = Source.find(params[:id])

    begin
      @storage = @source.storage
    rescue Storage::ErrNotFound
      return redirect_to :sources, notice: 'Error occurred'
    end
  end

  def new
    @source = Source.new
  end

  def create
    name  = params[:source][:name]
    key   = name

    storage = Storage.create
    return redirect_to :new_source, :notice => 'Failed to create storage' unless storage

    source = Source.new(name: name)
    source.user = current_user
    source.storage_key  = key

    if source.save
      redirect_to source
    else
      redirect_to :new_source, :notice => 'Failed to create source'
    end
  end

  def edit
    @source = Source.find(params[:id])
  end

  def update
    @source = Source.find(params[:id])

    if @source.update_attributes(params[:source].slice(:name))
      redirect_to @source
    else
      redirect_to edit_source_path(@source)
    end
  end

  def destroy
    @source = Source.find(params[:id])
    @source.destroy

    redirect_to '/'
  end
end
