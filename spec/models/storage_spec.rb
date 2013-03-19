require 'spec_helper'

describe Storage do
  describe '.open' do
    context 'when storage file already exists' do
      it 'instansiate object from storage key' do
        storage = FactoryGirl.create :storage
        storage.should respond_to :each, :push
      end
    end

    context 'when storage does not exists' do
      it "raise error Storage::ErrNotFound'" do
        expect {
          storage = Storage.find('dummy')
        }.to raise_error Storage::ErrNotFound
      end
    end
  end

  describe '.create' do
    it 'create file and instansiate' do
      storage = Storage.create
      Storage.should be_has_key storage.key
    end
  end

  describe '#push' do
    it 'push entry' do
      storage = FactoryGirl.create :storage

      expect {
        storage.push('test content')
      }.to change(storage, :count).by(1)

      e = storage.first
      e.should be_a_kind_of Entity
    end
  end
end
