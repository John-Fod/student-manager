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
  if school = School.find_by_name("#{school_name}")
  	visit new_school_student_path(school)
  else
  	visit new_school_student_path(0)
  end
end

# VISIT AN EDIT PAGE
When(/^I am on the edit student page for "(.*?)" in the school "(.*?)"$/) do |student_name,school_name|
	if student = Student.find_by_name("#{student_name}")
		if school = School.find_by_name("#{school_name}")
			visit edit_school_student_path(school,student)
		else
			visit edit_school_student_path(0,student)
		end
	else
		if school = School.find_by_name("#{school_name}")
			visit edit_school_student_path(school,0)
		else
			visit edit_school_student_path(0,0)
		end
	end
end

# VISIT A DELETE PAGE
When(/^I am on the delete student page for "(.*?)" in the school "(.*?)"$/) do |student_name,school_name|
	if student = Student.find_by_name("#{student_name}")
		if school = School.find_by_name("#{school_name}")
			visit delete_school_student_path(school,student)
		else
			visit delete_school_student_path(0,student)
		end
	else
		if school = School.find_by_name("#{school_name}")
			visit delete_school_student_path(school,0)
		else
			visit delete_school_student_path(0,0)
		end
	end
end

# VISIT A STUDENT'S PAGE
When(/^I am on the page for the student "(.*?)" in the school "(.*?)"$/) do |student_name,school_name|
	if student = Student.find_by_name("#{student_name}")
		if school = School.find_by_name("#{school_name}")
			visit school_student_path(school,student)
		else
			visit school_student_path(0,student)
		end
	else
		if school = School.find_by_name("#{school_name}")
			visit school_student_path(school,0)
		else
			visit school_student_path(0,0)
		end
	end
end




#THEN
#---------------------------