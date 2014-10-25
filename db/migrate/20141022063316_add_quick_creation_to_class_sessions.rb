class AddQuickCreationToClassSessions < ActiveRecord::Migration
  def change
  	add_column :class_sessions, :quick_creation, :boolean, :default => false
  end
end
