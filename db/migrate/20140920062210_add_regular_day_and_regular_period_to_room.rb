class AddRegularDayAndRegularPeriodToRoom < ActiveRecord::Migration
  def change
  	add_column :rooms, :regular_day, :integer
  	add_column :rooms, :regular_period, :integer
  end
end
