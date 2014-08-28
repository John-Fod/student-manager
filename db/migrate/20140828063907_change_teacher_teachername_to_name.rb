class ChangeTeacherTeachernameToName < ActiveRecord::Migration
  def change
  	rename_column :teachers, :teachername, :name
  end
end
