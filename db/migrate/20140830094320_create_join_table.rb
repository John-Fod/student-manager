class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :schools, :students do |t|
      # t.index [:school_id, :student_id]
      # t.index [:student_id, :school_id]
    end
  end
end
