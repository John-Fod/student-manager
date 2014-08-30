class School < ActiveRecord::Base

	validates :name, :presence => true, :length => {:in => 2..35}
	validates :headmaster, :presence => true

	belongs_to :headmaster, class_name: "Teacher", foreign_key: "headmaster_id"


	#-----METHODS
	#------------

	#-CHECK IF A USER CAN EDIT A USER OBJECT
	def editable_by? editor=nil
		return true if((editor)&&(self.headmaster==editor))
	end


end
