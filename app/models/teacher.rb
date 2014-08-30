class Teacher < ActiveRecord::Base

	attr_accessor :password

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	before_save :encrypt_password

	validates_confirmation_of :password

	validates :password, :presence => true, :length => {:in => 3..25}, :on => :create
	validates :name, :presence => true, :uniqueness => true, :length => {:in => 2..25}
	validates :email, presence: true, :uniqueness => true, format: { with: VALID_EMAIL_REGEX }

	has_many :schools, :foreign_key => 'headmaster_id'


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

end
