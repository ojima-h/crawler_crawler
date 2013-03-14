require 'spec_helper'

describe Source do
  prepare_storage

  describe '#source' do
    it 'inflate Storage::Base subclass from @name' do
      user = FactoryGirl.create(:user)
      source = FactoryGirl.create(:source, user_id: user.id)

      pending 'Check'
      source.storage.should be_a_kind_of Storage::File
    end
  end
end
