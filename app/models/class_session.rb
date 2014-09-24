class ClassSession < ActiveRecord::Base

	validates :school, :presence => true

	belongs_to :teacher
	belongs_to :room
	belongs_to :school

	has_and_belongs_to_many :teachers
	has_and_belongs_to_many :students


end
