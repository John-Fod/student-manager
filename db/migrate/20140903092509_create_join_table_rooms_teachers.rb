class CreateJoinTableRoomsTeachers < ActiveRecord::Migration
  def change
    create_join_table :rooms, :teachers do |t|
      # t.index [:room_id, :teacher_id]
      # t.index [:teacher_id, :room_id]
    end
  end
end
