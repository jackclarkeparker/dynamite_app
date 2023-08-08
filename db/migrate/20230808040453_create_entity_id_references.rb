class CreateEntityIDReferences < ActiveRecord::Migration[7.0]
  def change
    create_table :entity_id_references do |t|
      t.integer :tutor_entity_id, default: 0
      t.integer :contact_entity_id, default: 0

      t.timestamps
    end
  end
end
