class AddWeightToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :weight, :float, default: 1
  end
end
