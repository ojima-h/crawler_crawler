class Source < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :klass

  def storage
    @klass ||= eval "Storage::#{klass}"
    @core  ||= @klass.new(name)
  end
end






