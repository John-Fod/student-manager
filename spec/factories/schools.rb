# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :school do
    headmaster Teacher.last
    name "MyString"
    summary "MyString"
    student_count 0
  end
end
