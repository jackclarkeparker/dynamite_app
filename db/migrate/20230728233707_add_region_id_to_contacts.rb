class AddRegionIdToContacts < ActiveRecord::Migration[7.0]
  def change
    add_reference :contacts, :region, null: false, foreign_key: true
  end
end
