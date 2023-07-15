class RenameOccupancyToAvailability < ActiveRecord::Migration[7.0]
  def change
    rename_column :lessons, :occupancy, :availability
  end
end
