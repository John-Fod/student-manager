class AddClassSessionStatus < ActiveRecord::Migration
  def change
  	add_column :class_sessions, :status, :integer, :default => 0
  end
end
