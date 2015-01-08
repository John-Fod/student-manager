#GIVEN
#---------------------------

# MAKING PERIODS
Given (/^the following periods:$/) do |table|
	table.hashes.each do |attributes|
		attributes[:school] = School.find_by_name("#{attributes[:school]}")
		attributes[:start_at] = "#{Time.now.year}-#{Time.now.month}-#{Time.now.day} #{attributes[:start_at]}:00:00"
		attributes[:end_at] = "#{Time.now.year}-#{Time.now.month}-#{Time.now.day} #{attributes[:start_at]}:50:00"
		FactoryGirl.create(:period, attributes)
	end
end

#WHEN
#---------------------------



# VISIT A NEW PAGE
When(/^I am on the new period page for the school "(.*?)"$/) do |school_name|
  if school = School.find_by_name("#{school_name}")
  	visit new_school_period_path(school)
  else
  	visit new_school_period_path(0)
  end
end



# VISIT AN EDIT PAGE
When(/^I am on the edit period page for the school "(.*?)" and the period "(.*?)"$/) do |school_name, period_name|
	# GET THE SCHOOL
	if school = School.find_by_name("#{school_name}")
		school_id = school.to_param
	else
		school_id = 0
	end
	# GET THE ROOM
	if period = Period.find_by_name("#{period_name}")
		period_id = period.to_param
	else
		period_id = 0
	end
	# VISIT THE EDIT PAGE
	visit edit_school_period_path(school_id,period_id)
end


# VISIT A DELETE PAGE
When(/^I am on the delete period page for the school "(.*?)" and the period "(.*?)"$/) do |school_name, period_name|
	# GET THE SCHOOL
	if school = School.find_by_name("#{school_name}")
		school_id = school.to_param
	else
		school_id = 0
	end
	# GET THE ROOM
	if period = Period.find_by_name("#{period_name}")
		period_id = period.to_param
	else
		period_id = 0
	end
	# VISIT THE EDIT PAGE
	visit delete_school_period_path(school_id,period_id)
end


When (/^I select the room "(.*?)" for period "(.*?)" and teacher "(.*?)"$/) do |room_name, period_name, teacher_name|
	room = Room.find_by_name("#{room_name}")
	period = Period.find_by_name("#{period_name}")
	teacher = Teacher.find_by_name("#{teacher_name}")
	dropdown_id = "select-room-for-#{teacher.to_param}-#{period.to_param}"
	submit_id = "add-session-period-#{period.to_param}-teacher-#{teacher.to_param}"
	select "#{room.name}", :from => "#{dropdown_id}"
	click_button("#{submit_id}")
end




#THEN
#---------------------------