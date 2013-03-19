# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :storage, :class => 'Storage' do
    after(:create) do |storage|
      storage.push 'foo'
      storage.push 'bar'
    end
  end
end
