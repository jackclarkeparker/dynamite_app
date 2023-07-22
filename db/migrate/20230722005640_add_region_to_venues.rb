class AddRegionToVenues < ActiveRecord::Migration[7.0]
  def change
    add_reference :venues, :region, null: false, foreign_key: true
  end
end
