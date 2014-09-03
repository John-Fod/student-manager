# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :room do
    name "MyString"
    summary "MyText"
    school_id 1
    founding_teacher_id 1
  end
end
