class Storage::Mongo
  include Mongoid::Document
  include Enumerable

  field :data

  def each
    data.reverse_each do |d|
      yield Entity.new d
    end
  end

  def push(item)
    data.push item
    save
  end

  def key
    id.to_s
  end
end
