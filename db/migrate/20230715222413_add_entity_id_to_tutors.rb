class AddEntityIdToTutors < ActiveRecord::Migration[7.0]
  def change
    add_column :tutors, :entity_id, :integer
  end
end
