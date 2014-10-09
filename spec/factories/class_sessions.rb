# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :class_session do
    room Room.last
    teacher Teacher.last
    school School.last
    period Period.last
    held_at Time.now.beginning_of_day
    day Date.today.beginning_of_day
  end
end
