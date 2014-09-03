#GIVEN
#---------------------------



#WHEN
#---------------------------

# VISIT AN EDIT PAGE
When(/^I am on the new room page for the school "(.*?)"$/) do |school_name|
  school = School.find_by_name("#{school_name}")
  visit new_school_room_path(school)
end

# VISIT A DELETE PAGE
When(/^I am on the delete room page for "(.*?)"$/) do |room|
	room = Room.find_by_name("#{room}")
	visit delete_school_room_path(room.schoo,room)
end




#THEN
#---------------------------