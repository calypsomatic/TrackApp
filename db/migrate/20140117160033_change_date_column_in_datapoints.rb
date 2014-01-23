class ChangeDateColumnInDatapoints < ActiveRecord::Migration
  def up
    remove_column :datapoints, :date
    add_column :datapoints, :date, :Date
  end

  def down
    remove_column :datapoints, :date
    add_column :datapoints, :date, :datetime
  end
end
