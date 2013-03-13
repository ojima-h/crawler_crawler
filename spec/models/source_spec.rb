require 'spec_helper'

describe Source do
  prepare_source

  describe '#source' do
    it 'inflate Storage::Base subclass from @klass and @name' do
      user = FactoryGirl.create(:user)
      source = FactoryGirl.create(:source, user_id: user.id)

      source.storage.should be_a_kind_of Storage::File
    end
  end
end
