# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_source do
    source_class "File"
    name         "test"
  end
end
