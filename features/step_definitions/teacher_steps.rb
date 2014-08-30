#GIVEN
#---------------------------

# MAKING TEACHERS
Given (/^the following teachers:$/) do |table|
	table.hashes.each do |attributes|
		FactoryGirl.create(:teacher, attributes)
	end
end



#WHEN
#---------------------------

# VISIT AN EDIT PAGE
When(/^I am on the edit teacher page for "(.*?)"$/) do |teacher_name|
  teacher = Teacher.find_by_name("#{teacher_name}")
  visit edit_teacher_path(teacher)
end




#THEN
#---------------------------