class SourceFactory
  def self.create(user: nil, name: '', source_class: '', **param)
    us = UserSource.new {|us|
      us.user = user
      us.name = name
      us.source_class = source_class
    }
    us.save
    us.source
  end
end








