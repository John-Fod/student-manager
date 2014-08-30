#GIVEN
#---------------------------



#WHEN
#---------------------------

# VISIT AN EDIT PAGE
When(/^I am on the new student page for the school "(.*?)"$/) do |school_name|
  school = School.find_by_name("#{school_name}")
  visit new_school_student_path(school)
end

# VISIT A DELETE PAGE
When(/^I am on the delete student page for "(.*?)"$/) do |student|
	student = Student.find_by_name("#{student}")
	visit delete_student_path(student)
end




#THEN
#---------------------------