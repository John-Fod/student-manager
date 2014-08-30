# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student do
    name "MyString"
    about "MyText"
    level "MyText"
  end
end
