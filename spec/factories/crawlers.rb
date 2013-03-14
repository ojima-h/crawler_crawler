# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :crawler do
    user_id { FactoryGirl.create(:user).id }
    name 'test'
    key  'test'

    strategy 'None'
    params   { {p: 1, q: 2} }
  end
end
