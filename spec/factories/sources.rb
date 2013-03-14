# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :source do
    name         "test"
    storage_key  { Storage.create.key }
  end
end
