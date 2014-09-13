class CreateClassSessions < ActiveRecord::Migration
  def change
    create_table :class_sessions do |t|
      t.integer :room_id
      t.integer :teacher_id
      t.integer :school_id
      t.string :name
      t.text :summary
      t.datetime :held_at

      t.timestamps
    end
  end
end
