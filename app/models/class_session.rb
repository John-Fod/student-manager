class ClassSession < ActiveRecord::Base

	validates :school, :presence => true
	validates :period, :presence => true, :uniqueness => {:scope => [:school, :teacher, :day]}
	validates :teacher, :presence => true
	validates :room, :presence => true

	belongs_to :teacher
	belongs_to :room
	belongs_to :school
	belongs_to :period


	has_and_belongs_to_many :students


end
