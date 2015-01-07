class ClassSession < ActiveRecord::Base

	validates :school, :presence => true
	validates :period, :presence => true, :uniqueness => {:scope => [:school, :teacher, :day]}
	validates :teacher, :presence => true

	belongs_to :teacher
	belongs_to :room
	belongs_to :school
	belongs_to :period

	has_and_belongs_to_many :students

	before_save :add_start_and_end_at

	@@status = [
		"On Schedule",
		"Cancelled",
		"Finished"
	]

	def self.status
		@@status
	end

	def display_name
		if self.name && self.name!=""
			return self.name
		elsif self.room
			return "#{self.room.name} - #{self.day.strftime('%b %d')}"
		else
			return "Session - #{self.day.strftime('%b %d')}"
		end
	end

	def finished?
		if self.end_time.to_time.utc < Time.now.utc
			return true
		else
			return false
		end
	end

	def add_start_and_end_at
		day = self.day
		period_start = self.period.start_at
		period_end = self.period.end_at
		self.start_time = DateTime.new(day.year, day.month, day.day, period_start.hour, period_start.min, period_start.sec)
		self.end_time = DateTime.new(day.year, day.month, day.day, period_end.hour, period_end.min, period_end.sec)
	end

	def status_name
		status_integer = self.status
		ClassSession.status[status_integer]
	end


end
