class AddStartAtAndFinishAtToClassSession < ActiveRecord::Migration
  def change
  	add_column :class_sessions, :start_time, :datetime
  	add_column :class_sessions, :end_time, :datetime
  end
end
