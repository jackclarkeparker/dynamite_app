class AddOccupancyToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :occupancy, :integer
  end
end
