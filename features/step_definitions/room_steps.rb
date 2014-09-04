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
When(/^I am on the delete room page for "(.*?)"$/) do |room|
	if room = Room.find_by_name("#{room}")
		visit delete_school_room_path(room.school,room)
	else
		visit delete_school_room_path(room.school,0)
	end
end




#THEN
#---------------------------