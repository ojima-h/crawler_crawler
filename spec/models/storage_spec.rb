require 'spec_helper'

describe Storage do
  describe '.open' do
    context 'when storage file already exists' do
      prepare_storage
      it 'instansiate object from storage key' do
        storage = Storage.open('test')
        storage.should respond_to :each, :push
      end
    end

    context 'when storage does not exists' do
      it "raise error Storage::ErrNotFound'" do
        expect {
          storage = Storage.open('test')
        }.to raise_error Storage::ErrNotFound
      end
    end
  end

  describe '.create' do
    it 'create file and instansiate' do
      storage = Storage.create('test')
      File.should be_exist './db/files/test.json'
    end

    after :all do
      f = './db/files/test.json'
      File.unlink f if File.exist? f
    end
  end
end
