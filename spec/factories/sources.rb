# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :source do
    klass "File"
    name         "test"
  end
end
