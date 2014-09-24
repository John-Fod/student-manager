class AddRegularTeacherToRoom < ActiveRecord::Migration
  def change
  	add_column :rooms, :regular_teacher_id, :integer
  end
end
