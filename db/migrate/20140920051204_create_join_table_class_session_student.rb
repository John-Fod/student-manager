class CreateJoinTableClassSessionStudent < ActiveRecord::Migration
  def change
    create_join_table :class_sessions, :students do |t|
      # t.index [:class_session_id, :student_id]
      # t.index [:student_id, :class_session_id]
    end
  end
end
