class AddRegionIdToVenues < ActiveRecord::Migration[7.0]
  def up
    add_column :venues, :region_id, :integer
  end

  def down
    drop_column :venues, :region_id
  end
end
