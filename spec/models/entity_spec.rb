require 'spec_helper'

describe Entity do
  it 'enumerate entries' do
    storage = FactoryGirl.create :storage

    storage.should respond_to :to_a
    entity = storage.to_a[0]

    entity.should be_a_kind_of Entity
    entity.contents.should be_a_kind_of String
    entity.created_at.should be_a_kind_of DateTime

    entity.contents.should match /bar/
  end

end
