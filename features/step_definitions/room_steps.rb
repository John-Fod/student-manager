#GIVEN
#---------------------------

# MAKING ROOMS
Given (/^the following rooms:$/) do |table|
	table.hashes.each do |attributes|
		attributes[:school] = School.find_by_name("#{attributes[:school]}")
		attributes[:founding_teacher] = Teacher.find_by_name("#{attributes[:teacher]}")
		FactoryGirl.create(:room, attributes)
	end
end

#WHEN
#---------------------------



# VISIT A NEW PAGE
When(/^I am on the new room page for the school "(.*?)"$/) do |school_name|
  if school = School.find_by_name("#{school_name}")
  	visit new_school_room_path(school)
  else
  	visit new_school_room_path(0)
  end
end



# VISIT AN EDIT PAGE
When(/^I am on the edit room page for the school "(.*?)" and the room "(.*?)"$/) do |school_name, room_name|
	# GET THE SCHOOL
	if school = School.find_by_name("#{school_name}")
		school_id = school.to_param
	else
		school_id = 0
	end
	# GET THE ROOM
	if room = Room.find_by_name("#{room_name}")
		room_id = room.to_param
	else
		room_id = 0
	end
	# VISIT THE EDIT PAGE
	visit edit_school_room_path(school_id,room_id)
end


# VISIT A DELETE PAGE
When(/^I am on the delete room page for the school "(.*?)" and the room "(.*?)"$/) do |school_name, room_name|
	# GET THE SCHOOL
	if school = School.find_by_name("#{school_name}")
		school_id = school.to_param
	else
		school_id = 0
	end
	# GET THE ROOM
	if room = Room.find_by_name("#{room_name}")
		room_id = room.to_param
	else
		room_id = 0
	end
	# VISIT THE EDIT PAGE
	visit delete_school_room_path(school_id,room_id)
end



# VISIT A DELETE PAGE
When(/^I am on the delete room page for "(.*?)"$/) do |room|
	if room = Room.find_by_name("#{room}")
		visit delete_school_room_path(room.school,room)
	else
		visit delete_school_room_path(room.school,0)
	end
end


# VISIT A ROOMS'S PAGE
When(/^I am on the page for the room "(.*?)"$/) do |room_name|
	if room = Room.find_by_name("#{room_name}")
		visit school_room_path(room.school, room)
	else
		visit school_room_path(0,0)
	end
end

# VISIT A ROOM'S PAGE
When(/^I am on the show room page for the room "(.*?)" in the school "(.*?)"$/) do |room_name, school_name|
	if school = School.find_by_name("#{school_name}")
		if room = school.rooms.find_by_name("#{room_name}")
			visit school_room_path(school,room)
		else
			visit school_room_path(school,0)
		end
	else
		if room = Room.find_by_name("#{room_name}")
			visit school_room_path(0,room)
		else
			visit school_room_path(0,0)
		end
	end
end

# SELECT TODAY AS A ROOM'S REGULAR DAY
When(/^I select today's day of the week as the room's regular day$/) do
	today = Time.now.strftime("%A")
	select "#{today}", :from => "room_regular_day"
end

# SELECT A PERIOD FROM A DROPDOWN MENU
When(/^I select the period "(.*?)"$/) do |period_name|
	select "#{period_name}", :from => "room[regular_period_id]"
end




#THEN
#---------------------------

# CONFIRMING A CLASS IS SCHEDULED IN ONE WEEK
Then(/^I should see a class scheduled "(.*?)" week from today$/) do |number_of_weeks|
	target_time = Time.now.beginning_of_day+(number_of_weeks.to_i).weeks
	target_time_as_string = target_time.strftime('%A %b %d')
	find("#upcomming-class-sessions ul").should have_content("#{target_time_as_string}")
end