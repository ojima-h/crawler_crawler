require 'spec_helper'

describe UserSource do
  prepare_source

  describe '#source' do
    it 'inflate Sources::Base subclass from @source_class and @name' do
      user = FactoryGirl.create(:user)
      user_source = FactoryGirl.create(:user_source, user_id: user.id)

      user_source.source.should be_a_kind_of Sources::File
    end
  end
end
