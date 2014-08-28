# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do

	factory :teacher do
		name "Teacher"
		password "123"
		password_confirmation { "#{123}" }
		password_salt { BCrypt::Engine.generate_salt }
		password_hash { BCrypt::Engine.hash_secret(password, password_salt) }
		email { "#{name}@gmail.com".downcase }
	end

end