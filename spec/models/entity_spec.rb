require 'spec_helper'

describe Entity do
  prepare_storage

  it 'enumerate entries' do
    source = Storage.open(storage_key)

    source.should respond_to :to_a
    entity = source.to_a[0]

    entity.should be_a_kind_of Entity
    entity.contents.should be_a_kind_of String
    entity.created_at.should be_a_kind_of DateTime

    entity.contents.should match /bar/
  end

end
