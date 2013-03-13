class UserSource < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :source_class

  def source
    @klass  ||= eval "Sources::#{source_class}"
    @source ||= @klass.new(name)
  end
end
