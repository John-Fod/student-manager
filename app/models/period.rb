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

end
