class Period < ActiveRecord::Base
	
	validates :name, :presence => true, :length => {:in => 1..35}

	belongs_to :school

	def scheduled_class_session(day)
		if scheduled_class = ClassSession.where( day: day, period: self).all
			return scheduled_class
		else
			return false
		end
	end

	#-CHECK IF A USER CAN EDIT A USER OBJECT
	def editable_by? editor=nil
		return true if((editor)&&(self.school.editable_by? editor))
	end

end
