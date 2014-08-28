#GIVEN
#---------------------------




#WHEN
#---------------------------

# VISIT AN EDIT PAGE
When(/^I visit the edit teacher page for "(.*?)"$/) do |teacher_name|
  teacher = Teacher.find_by_name("#{teacher_name}")
  visit edit_teacher_path(teacher)
end




#THEN
#---------------------------