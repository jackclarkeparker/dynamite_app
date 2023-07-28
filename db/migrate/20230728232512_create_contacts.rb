class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.integer :entity_id
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.string :preferred_name
      t.string :email_address
      t.string :phone_number
      t.string :bank_account
      t.string :csc_number
      t.timestamp :valid_until

      t.timestamps
    end
  end
end
