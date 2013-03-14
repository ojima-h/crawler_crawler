module PrepareHelpers
  module Methods
    def source_file_name
      'test'
    end
    def source_file_path
      File.expand_path('./db/files/test.json')
    end

    def prepare_storage_file
      open source_file_path, 'w' do |f|
        f.write <<EOF
[
  {
    "contents":   "foo",
    "created_at": "2013/01/10 12:10"
  },
  {
    "contents":   "bar",
    "created_at": "2013/01/11 13:10"
  }
]
EOF
      end
    end
  end

  def prepare_storage
    include Methods

    before :all do
      prepare_storage_file
    end

    after :all do
      File.unlink source_file_path
    end
  end
end
