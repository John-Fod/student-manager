class Period < ActiveRecord::Base
	
	validates :name, :presence => true, :length => {:in => 1..35}

	belongs_to :school

end
