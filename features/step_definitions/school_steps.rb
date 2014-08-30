#GIVEN
#---------------------------


# MAKING SCHOOLS
Given (/^the following schools:$/) do |table|
	table.hashes.each do |attributes|
		attributes[:headmaster] = Teacher.find_by_name("#{attributes[:headmaster]}")
		FactoryGirl.create(:school, attributes)
	end
end



#WHEN
#---------------------------

# VISIT AN EDIT PAGE
When(/^I am on the edit school page for "(.*?)"$/) do |school_name|
  school = School.find_by_name("#{school_name}")
  visit edit_school_path(school)
end

# VISIT A DELETE PAGE
When(/^I am on the delete school page for "(.*?)"$/) do |school_name|
	school = School.find_by_name("#{school_name}")
	visit delete_school_path(school)
end




#THEN
#---------------------------