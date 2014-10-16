module ApplicationHelper

	#---RENDER A PARCEL FOR AN ENTRY
	def parcel_for entry
		if entry.is_a?(School)
			render 'schools/parcel', :entry => entry
		elsif entry.is_a?(Room)
			render 'rooms/parcel', :entry => entry
		elsif entry.is_a?(Teacher)
			render 'teachers/parcel', :entry => entry
		elsif entry.is_a?(Student)
			render 'students/parcel', :entry => entry
		elsif entry.is_a?(ClassSession)
			render 'class_sessions/parcel', :entry => entry
		end
	end

end
