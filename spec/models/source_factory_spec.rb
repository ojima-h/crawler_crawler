require 'spec_helper'

describe SourceFactory do
  prepare_source

  describe '#create' do
    it 'create a crawler from accessor' do
      user = FactoryGirl.create(:user)

      SourceFactory.should respond_to :create

      expect {
        source = SourceFactory.create( user:         user,
                                       klass: 'File',
                                       name:          'test' )
      }.to change(Source, :count).by(1)
    end
  end
end

