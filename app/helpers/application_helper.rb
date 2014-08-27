module ApplicationHelper

	#---RENDER A PARCEL FOR AN ENTRY
	def parcel_for entry
		if entry.is_a?(School)
			render 'schools/parcel', :entry => entry
		end
	end

end
