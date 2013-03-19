require 'date'
require 'active_support'

class Entity
  attr_reader :contents
  attr_reader :created_at

  def initialize(data)
    d = data.symbolize_keys
    @contents = d[:contents] or raise 'No Content'

    raise 'No Created Date' unless d[:created_at]
    @created_at = ::DateTime.parse(d[:created_at])
  end
end
