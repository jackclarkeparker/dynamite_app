class AddRegionToTutors < ActiveRecord::Migration[7.0]
  def change
    add_reference :tutors, :region, null: false, foreign_key: true
  end
end
