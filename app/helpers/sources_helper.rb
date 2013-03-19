module SourcesHelper
  require 'namespace'

  def sources_class_list
    Dir[Rails.root.join("app/models/source_class/**/*.rb")].map {|path|
      File.basename(path, ".rb").camelize
    }
  end

  def crawler_strategy_field(crawler, strategy, namespace: nil)
    ns = namespace ? namespace.clone : []
    ns << Namespace.basename(strategy.name)

    field_name = ns.reduce {|fn, n| fn + "[#{n}]"}

    outputs = ActiveSupport::SafeBuffer.new
    if crawler.has_strategy? strategy
      crawler.params.each do |name, value|
        n = "#{field_name}[#{name}]"
        outputs << label_tag(n, name)
        outputs << crawler_param_tag(n, crawler.params_type[name], value)
      end
    else
      strategy.params_type.each do |name, type|
        n = "#{field_name}[#{name}]"
        outputs << label_tag(n, name)
        outputs << crawler_param_tag(n, type, nil)
      end
    end
    outputs
  end
  def crawler_param_tag(name, type, value)
    case type
    when :string
      text_field_tag name, value
    end
  end

  def crawler_field_templates(crawler, namespace: nil)
    templates = Hash.new
    Crawler.strategies.each do |strategy|
      templates[strategy.to_param] = crawler_strategy_field(crawler, strategy, namespace: namespace)
    end
    templates
  end
end
