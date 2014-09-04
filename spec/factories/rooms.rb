# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :room do
    name "MyString"
    summary "MyText"
    school School.last
    founding_teacher Teacher.last
  end
end
