# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :source do
    name         "test"
    storage_key  { name }
  end
end
