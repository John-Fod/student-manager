class CreateJoinTableCoursesSchools < ActiveRecord::Migration
  def change
    create_join_table :courses, :schools do |t|
      # t.index [:course_id, :school_id]
      # t.index [:school_id, :course_id]
    end
  end
end
