#GIVEN
#---------------------------



# MAKING TEACHERS
Given (/^the following teachers:$/) do |table|

	table.hashes.each do |attributes|
		FactoryGirl.create(:teacher, attributes)
	end

end



# LOGGING IN AS A TEACHER
Given (/^I am logged in as "(.*?)"$/) do |email|

	visit(login_path)
	fill_in("email", :with => "#{email}")
	fill_in("password", :with => "123")
	click_button("login")

end




#WHEN
#---------------------------



# VISIT A PAGE
When(/^I am on the "(.*?)" page$/) do |path_name|

  visit send("#{path_name}_path")

end


# FILL IN A FORM TEXT INPUT
When(/^I fill in "(.*?)" with "(.*?)"$/) do |form_name, form_value|

	fill_in("#{form_name}", :with => "#{form_value}")

end


# PRESS THE BUTTON ON A FORM
When(/^I press "(.*?)"$/) do |button_name|

	click_button("#{button_name}")

end



#THEN
#---------------------------



# SHOW ME THE PAGE
Then (/^show me the page$/) do

	save_and_open_page
  
end

# ASSERT I AM ON A PAGE
Then(/^I should be on the "(.*?)" page$/) do |path_name|

	assert page.current_path == "#{path_name}"

end


# VISIBLE TEXT
Then(/^I should see "(.*?)"$/) do |visible_text|

	page.should have_content("#{visible_text}")

end



# VISIBLE TEXT IN AN ELEMENT
Then(/^I should see the text "(.*?)" in the element "(.*?)"$/) do |visible_text, selector|

	find("#{selector}").should have_content("#{visible_text}")

end



# NOT VISIBLE TEXT IN AN ELEMENT
Then(/^I should not see the text "(.*?)" in the element "(.*?)"$/) do |visible_text, selector|

	find("#{selector}").assert_no_text("#{visible_text}")

end


# FLASH MESSAGES
Then(/^I should see a flash "(.*?)" of "(.*?)"$/) do |flash_type, flash_message|

	find(".#{flash_type}").should have_content("#{flash_message}")

end


# ERROR MESSAGES
Then(/^I should see an error message of "(.*?)"$/) do |error_message|

	find(".error-messages").should have_content("#{error_message}")

end