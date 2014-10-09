class ChangeClassPeriodToPeriod < ActiveRecord::Migration
  def change
  	rename_column :class_sessions, :class_period, :period_id
  end
end
