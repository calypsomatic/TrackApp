class DropDataPoints < ActiveRecord::Migration
  def up
    drop_table :data_points
  end

  def down
    create_table :data_points do |t|
      t.integer  "moment_id"  
      t.integer  "amount"
      t.datetime "date"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
