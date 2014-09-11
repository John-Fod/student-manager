class Student < ActiveRecord::Base

	validates :name, :presence => true, :uniqueness => {:scope => :school_id}, :length => {:in => 2..35}
	validates :school, :presence => true

	belongs_to :school

	has_and_belongs_to_many :schools
	has_and_belongs_to_many :rooms


	#-----METHODS
	#------------

	#-CHECK IF A USER CAN EDIT A USER OBJECT
	def editable_by? editor=nil
		return true if((editor)&&(self.school.headmaster==editor))
	end

end
