require 'date'
require 'active_support'

class Entity
  attr_reader :contents
  attr_reader :created_at

  def initialize(data)
    @contents = data['contents'] or raise 'No Content'

    raise 'No Created Date' unless data['created_at']
    @created_at = ::DateTime.parse(data['created_at'])
  end
end
