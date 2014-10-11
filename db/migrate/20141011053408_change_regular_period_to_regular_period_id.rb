class ChangeRegularPeriodToRegularPeriodId < ActiveRecord::Migration
  def change
  	rename_column :rooms, :regular_period, :regular_period_id
  end
end
