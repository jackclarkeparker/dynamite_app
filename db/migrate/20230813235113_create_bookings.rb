class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.string :type
      t.references :lesson, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true
      t.string :additional_details
      t.string :form_values
      t.boolean :currently_on_list

      t.timestamps
    end
  end
end
