#GIVEN
#---------------------------


# MAKING SCHOOLS
Given (/^the following schools:$/) do |table|
	table.hashes.each do |attributes|
		attributes[:headmaster] = Teacher.find_by_name("#{attributes[:headmaster]}")
		school = FactoryGirl.create(:school, attributes)
	end
end

# A SCHOOL IS DELETE
Given (/^the school "(.*?)" is deleted$/) do |school_name|
	School.find_by_name("#{school_name}").destroy
end

# DELETING SCHOOLS
Given (/^I delete the school "(.*?)"$/) do |school_name|
	if school = School.find_by_name("#{school_name}")
		visit delete_school_path(school)
		click_link("confirm_deletion")
	else
		visit delete_school_path(0)
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

# A BANNER FOR A SCHOOL SHOULD BE VISIBLE
When(/^I should see a banner for the school "(.*?)"$/) do |school_name|
	school = School.find_by_name("#{school_name}")
	find(".banner").should have_content("#{school.name}")
end