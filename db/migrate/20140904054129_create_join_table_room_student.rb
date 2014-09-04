class CreateJoinTableRoomStudent < ActiveRecord::Migration
  def change
    create_join_table :rooms, :students do |t|
      # t.index [:room_id, :student_id]
      # t.index [:student_id, :room_id]
    end
  end
end
