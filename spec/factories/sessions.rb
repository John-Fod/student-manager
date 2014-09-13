# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :session do
    school_id 1
    teacher_id 1
    room_id 1
    name "MyString"
    summary "MyText"
  end
end
