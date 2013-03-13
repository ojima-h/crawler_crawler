module SourcesHelper
  def sources_class_list
    Dir[Rails.root.join("app/models/source_class/**/*.rb")].map {|path|
      File.basename(path, ".rb").camelize
    }
  end
end
