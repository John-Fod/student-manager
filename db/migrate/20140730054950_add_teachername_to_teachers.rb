class AddTeachernameToTeachers < ActiveRecord::Migration
  def change
  	add_column :teachers, :teachername, :string
  end
end
