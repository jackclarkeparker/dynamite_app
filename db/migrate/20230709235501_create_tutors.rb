class CreateTutors < ActiveRecord::Migration[7.0]
  def change
    create_table :tutors do |t|
      t.string :preferred_name
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :phone_number
      t.string :mail_address

      t.timestamps
    end
  end
end
