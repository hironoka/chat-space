FactoryGirl.define do
  factory :message do
    body   "It's a test"
    image  ""
    group
    user
  end
end
