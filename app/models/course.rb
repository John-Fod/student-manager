class Course < ActiveRecord::Base

	validates :name, :presence => true, :uniqueness => true, :length => {:in => 2..25}

	belongs_to :founding_teacher, class_name: "Teacher", foreign_key: "founding_teacher_id"

	has_and_belongs_to_many :schools


	#-----METHODS
	#------------


	#-CHECK IF A USER CAN EDIT A USER OBJECT
	def editable_by? editor=nil
		return true if((editor)&&(self.founding_teacher)&&(self.founding_teacher==editor))
	end

end
