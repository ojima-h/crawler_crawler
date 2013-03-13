module SourcesHelper
  def sources_class_list
    Dir[Rails.root.join("app/models/sources/**/*.rb")].map {|path|
      File.basename(path, ".rb").camelize
    }
  end
end
