require 'spec_helper'

describe Storage do
  describe '.open' do
    context 'when storage file already exists' do
      prepare_storage
      it 'instansiate object from storage key' do
        storage = Storage.open(storage_key)
        storage.should respond_to :each, :push
      end
    end

    context 'when storage does not exists' do
      it "raise error Storage::ErrNotFound'" do
        expect {
          storage = Storage.open('dummy')
        }.to raise_error Storage::ErrNotFound
      end
    end
  end

  describe '.create' do
    it 'create file and instansiate' do
      storage = Storage.create
      Storage.should be_exists storage.key
    end
  end
end
