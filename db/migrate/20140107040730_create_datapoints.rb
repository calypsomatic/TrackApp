class CreateDatapoints < ActiveRecord::Migration
  def change
    create_table :datapoints do |t|
      t.integer :goal_id
      t.integer :amount
      t.datetime :date

      t.timestamps
    end
  end
end
