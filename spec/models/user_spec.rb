require 'spec_helper'

describe User do
  prepare_storage

  describe '#source' do
    it 'inflate Storage::Base subclass from @name of Source' do
      user = FactoryGirl.create(:user)
      source = FactoryGirl.create(:source_factory, user: user)
    end
  end
end
