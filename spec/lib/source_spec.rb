require 'sources/file'
require 'source'

describe Source do
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

  it 'enumerate entries' do
    sources = Sources::File.new(@file_path)

    sources.should respond_to :to_a
    source = sources.to_a[0]

    source.should be_a_kind_of Source
    source.contents.should be_a_kind_of String
    source.created_at.should be_a_kind_of DateTime
  end

  after :all do
    File.unlink @file_path
  end
end
