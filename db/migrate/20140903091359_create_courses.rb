class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :summary
      t.integer :school_id
      t.integer :founding_teacher_id

      t.timestamps
    end
  end
end
