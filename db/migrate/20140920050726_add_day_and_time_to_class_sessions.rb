class AddDayAndTimeToClassSessions < ActiveRecord::Migration
  def change
  	add_column :class_sessions, :day, :datetime
  	add_column :class_sessions, :class_period, :integer
  end
end
