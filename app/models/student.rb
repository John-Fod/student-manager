class Student < ActiveRecord::Base

	validates :name, :presence => true, :length => {:in => 2..35}

	has_and_belongs_to_many :schools
	has_and_belongs_to_many :rooms


	#-----METHODS
	#------------

	#-CHECK IF A USER CAN EDIT A USER OBJECT
	def editable_by? editor=nil
		return true if((editor)&&(self.headmaster==editor))
	end

end
