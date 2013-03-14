require 'spec_helper'

describe Storage do
  describe '.open' do
    prepare_storage
    it 'instansiate object from storage key' do
      storage = Storage.open('test')
      storage.should respond_to :each, :push
    end
  end
end

