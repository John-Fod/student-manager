#GIVEN
#---------------------------

# MAKING STUDENTS
Given (/^the following students:$/) do |table|
	table.hashes.each do |attributes|
		attributes[:school] = School.find_by_name("#{attributes[:school]}")
		FactoryGirl.create(:student, attributes)
	end
end

#WHEN
#---------------------------

# VISIT A CREATE PAGE
When(/^I am on the new student page for the school "(.*?)"$/) do |school_name|
  school = School.find_by_name("#{school_name}")
  visit new_school_student_path(school)
end

# VISIT AN EDIT PAGE
When(/^I am on the edit student page for "(.*?)"$/) do |student_name|
  student = Student.find_by_name("#{student_name}")
  visit edit_student_path(student)
end

# VISIT A DELETE PAGE
When(/^I am on the delete student page for "(.*?)"$/) do |student_name|
	student = Student.find_by_name("#{student_name}")
	visit delete_student_path(student)
end

# VISIT A STUDENT'S PAGE
When(/^I am on the page for the student "(.*?)"$/) do |student_name|
	if student = Student.find_by_name("#{student_name}")
		visit student_path(student)
	else
		visit student_path(0)
	end
end




#THEN
#---------------------------