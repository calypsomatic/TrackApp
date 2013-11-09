class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :objective, null: false
      t.integer :weekly_frequency
      t.integer :weekly_quantity
      t.integer :user_id

      t.timestamps
    end
  end
end
