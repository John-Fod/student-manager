class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.integer :headmaster_id
      t.string :name
      t.string :summary
      t.integer :student_count, :default => 0

      t.timestamps
    end
  end
end
