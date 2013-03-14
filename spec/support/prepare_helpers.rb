module PrepareHelpers
  module Methods
    def source_file_path
      File.expand_path("./db/files/test_#{storage_key}.json")
    end

    def storage_key
      'test'
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

  module Matchers
    RSpec::Matchers.define :be_a_storage_key do
      match do |key|
        File.exist? "./db/files/test_#{key.to_s}.json"
      end
    end
  end

  def prepare_storage
    include Methods

    before :all do
      prepare_storage_file
    end
  end
end
