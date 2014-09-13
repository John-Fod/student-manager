# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :class_session do
    room_id 1
    teacher_id 1
    school_id 1
    name "MyString"
    summary "MyText"
    held_at "2014-09-13 18:29:08"
  end
end
