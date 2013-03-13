module PrepareHelpers
  def prepare_source
    before :all do
      @file_path = File.expand_path('./db/files/test.json')

      open @file_path, 'w' do |f|
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

    after :all do
      File.unlink @file_path
    end

    define_method :source_file_name do
      'test'
    end
  end
end
