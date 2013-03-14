module StorageHelper
  module Methods
    def storage_key
      @storage.key
    end

    def _prepare_storage_data
      @storage = Storage.create
      @storage.push( { "contents" => "foo", "created_at" => "2013/01/10 12:10" } )
      @storage.push( { "contents" => "bar", "created_at" => "2013/01/11 13:10" } )
    end
  end

  def prepare_storage
    include Methods

    before :all do
      _prepare_storage_data
    end
  end
end
