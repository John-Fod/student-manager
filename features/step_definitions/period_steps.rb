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