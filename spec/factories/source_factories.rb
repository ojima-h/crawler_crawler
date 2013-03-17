FactoryGirl.define do
  factory :source_factory do
    name "test"
    user { FactoryGirl.create(:user) }
    crawler_strategy "Test"
    params ( { p: 1, q: 2} )
  end
end
