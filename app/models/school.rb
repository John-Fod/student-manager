class School < ActiveRecord::Base

	validates :name, :presence => true, :length => {:in => 2..35}
	validates :headmaster, :presence => true

	belongs_to :headmaster, class_name: "Teacher", foreign_key: "headmaster_id"


	#-----METHODS
	#------------


end
