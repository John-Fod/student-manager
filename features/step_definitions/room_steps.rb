#GIVEN
#---------------------------



#WHEN
#---------------------------

# VISIT AN EDIT PAGE
When(/^I am on the new room page for the school "(.*?)"$/) do |school_name|
  if school = School.find_by_name("#{school_name}")
  	visit new_school_room_path(school)
  else
  	visit new_school_room_path(0)
  end
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