class RemoveAvailabilityFromLessons < ActiveRecord::Migration[7.0]
  def change
    remove_column :lessons, :availability, :integer
  end
end
