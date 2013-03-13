class SourceFactory
  def self.create(user: nil, name: '', klass: '', **param)
    us = Source.new {|us|
      us.user = user
      us.name = name
      us.klass = klass
    }
    us.save
    us.storage
  end
end
