require 'spec_helper'

describe Source do
  prepare_storage

  describe '#storage' do
    it 'inflate Storage::Base subclass from @name' do
      user = FactoryGirl.create(:user)
      source = SourcesHelper::Factory.create(user: user)

      Source.find(source.id).storage.should be_a_kind_of Storage
    end
  end
end
