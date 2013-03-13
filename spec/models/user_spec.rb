require 'spec_helper'

describe User do
  prepare_source

  describe '#source' do
    it 'inflate Sources::Base subclass from @source_class and @name of UserSource' do
      user = FactoryGirl.create(:user)
      user_source = FactoryGirl.create(:user_source, user_id: user.id)
    end
  end
end
