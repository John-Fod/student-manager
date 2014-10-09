# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :period do
    name "MyString"
    school School.last
    start_at Time.now
    end_at Time.now
  end
end
