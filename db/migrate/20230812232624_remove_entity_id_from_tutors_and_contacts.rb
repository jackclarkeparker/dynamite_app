class RemoveEntityIDFromTutorsAndContacts < ActiveRecord::Migration[7.0]
  def change
    remove_column :contacts, :entity_id, :integer
    remove_column :tutors, :entity_id, :integer
  end
end
