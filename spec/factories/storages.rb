# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :storage, :class => 'Storage' do
    data [ { "contents" => "foo", "created_at" => "2013/01/10 12:10" } ,
           { "contents" => "bar", "created_at" => "2013/01/11 13:10" } ]
  end
end
