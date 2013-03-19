require 'date'
require 'active_support'

class Entity
  include Mongoid::Document

  embedded_in :storage

  field :contents,   type: String
  field :created_at, type: DateTime
end
