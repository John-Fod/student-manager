class Room < ActiveRecord::Base

	validates :name, :presence => true, :uniqueness => {:scope => :school_id}, :length => {:in => 2..25}
	validates :regular_period, :uniqueness => {:scope => [:school, :regular_teacher, :regular_day]}

	belongs_to :school
	belongs_to :founding_teacher, class_name: "Teacher", foreign_key: "founding_teacher_id"
	belongs_to :regular_teacher, class_name: "Teacher", foreign_key: "regular_teacher_id"
	belongs_to :regular_period, class_name: "Period", foreign_key: "regular_period_id"

	has_and_belongs_to_many :teachers
	has_and_belongs_to_many :students

	has_many :class_sessions


	#-----METHODS
	#------------


	#-ENCRYPT PASSWORD
	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end


	#-AUTHENTICATE USER
	def self.authenticate(email, password)
		teacher = find_by_email(email)
		teacher = find_by_name(email) unless teacher
		if teacher && teacher.password_hash == BCrypt::Engine.hash_secret(password, teacher.password_salt)
			teacher
		else
			nil
		end
	end


	#-CHECK IF A USER CAN EDIT A USER OBJECT
	def editable_by? editor=nil
		return true if((editor)&&(self==editor))
	end

	#-RETURN THE NAME OF THE DAY OF THE REGURLAR SCHEDULED DAY
	def regurlar_day_name
		day_number = self.regular_day.to_s
		case day_number
			when 0
				return "Sunday"
			when 1
				return "Monday"
			When 2
				return "Tuesday"
			When 3
				return "Wednesday"
			When 4
				return "Thursday"
			When 5
				return "Friday"
			When 6
				return "Saturday"
			else
				return self.regular_day
		end
	end
end
