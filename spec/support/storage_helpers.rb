module StorageHelper
  module Methods
    def storage_key
      @storage.key
    end

    def _prepare_storage_data
      @storage = Storage.create
      @storage.push( "foo" )
      @storage.push( "bar" )
    end
  end

  def prepare_storage
    include Methods

    before :all do
      _prepare_storage_data
    end
  end
end
