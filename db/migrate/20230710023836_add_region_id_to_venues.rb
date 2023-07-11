class AddRegionIdToVenues < ActiveRecord::Migration[7.0]
  def change
    add_column :venues, :region_id, :integer
  end
end
