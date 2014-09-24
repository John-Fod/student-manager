class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.integer :school_id
      t.datetime :start_at
      t.datetime :end_at
      t.string :name

      t.timestamps
    end
  end
end
