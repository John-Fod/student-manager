#GIVEN
#---------------------------

# MAKING PERIODS
Given (/^the following class sessions today:$/) do |table|
	table.hashes.each do |attributes|
		attributes[:school] = School.find_by_name("#{attributes[:school]}")
		attributes[:room] = Room.find_by_name("#{attributes[:room]}")
		attributes[:period] = Period.find_by_name("#{attributes[:period]}")
		attributes[:teacher] = Teacher.find_by_name("#{attributes[:teacher]}")
		attributes[:held_at] = attributes[:period].start_at
		FactoryGirl.create(:class_session, attributes)
	end
end

#WHEN
#---------------------------

When (/^I select the room "(.*?)" for period "(.*?)" and teacher "(.*?)"$/) do |room_name, period_name, teacher_name|
	room = Room.find_by_name("#{room_name}")
	period = Period.find_by_name("#{period_name}")
	teacher = Teacher.find_by_name("#{teacher_name}")
	dropdown_id = "select-room-for-#{teacher.to_param}-#{period.to_param}"
	submit_id = "add-session-period-#{period.to_param}-teacher-#{teacher.to_param}"
	select "#{room.name}", :from => "#{dropdown_id}"
	click_button("#{submit_id}")
end

When (/^I quickly delete the class session of "(.*?)" at "(.*?)"$/) do |room_name, period_name|
	room = Room.find_by_name("#{room_name}")
	period = Period.find_by_name("#{period_name}")
	deletion_id = "delete-period-room-#{room.to_param}-period-#{period.to_param}"
	click_link("#{deletion_id}")
end

When (/^I quickly add room "(.*?)" for period "(.*?)" and teacher "(.*?)"$/) do |room_name, period_name, teacher_name|
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