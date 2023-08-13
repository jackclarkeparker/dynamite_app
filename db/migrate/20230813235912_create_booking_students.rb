class CreateBookingStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :booking_students do |t|
      t.references :booking, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
