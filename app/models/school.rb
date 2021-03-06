class School < ActiveRecord::Base

	validates :name, :presence => true, :length => {:in => 2..35}
	validates :headmaster, :presence => true

	belongs_to :headmaster, class_name: "Teacher", foreign_key: "headmaster_id"

	has_many :students, :dependent => :destroy
	has_many :rooms, :dependent => :destroy
	has_many :class_sessions
	has_many :periods

	has_and_belongs_to_many :teachers
	has_and_belongs_to_many :courses


	#-----METHODS
	#------------

	#-CHECK IF A USER CAN EDIT A USER OBJECT
	def editable_by? editor=nil
		return true if((editor)&&(self.headmaster==editor))
	end

	def all_teachers
		teachers = Array.new
		teachers << self.headmaster
		return teachers
	end


end
