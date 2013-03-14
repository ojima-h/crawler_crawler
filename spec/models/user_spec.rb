require 'spec_helper'

describe User do
  prepare_storage

  describe '#source' do
    it 'inflate Storage::Base subclass from @klass and @name of Source' do
      user = FactoryGirl.create(:user)
      source = FactoryGirl.create(:source, user_id: user.id)
    end
  end
end
