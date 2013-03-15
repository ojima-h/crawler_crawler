require 'spec_helper'

describe User do
  prepare_storage

  describe '#source' do
    it 'inflate Storage::Base subclass from @name of Source' do
      user = FactoryGirl.create(:user)
      source = SourcesHelper::Factory.create(user: user)
    end
  end
end
