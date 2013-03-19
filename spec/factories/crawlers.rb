# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :crawler do
    user_id { FactoryGirl.create(:user).id }
    name 'test'
    storage_key  'test'

    strategy 'Test'
    params   { {p: 1, q: 2} }
  end
end
