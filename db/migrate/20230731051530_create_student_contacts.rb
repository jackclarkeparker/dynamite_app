class CreateStudentContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :student_contacts do |t|
      t.references :students, null: false, foreign_key: true
      t.references :contacts, null: false, foreign_key: true
      t.string :relation
      t.boolean :primary_contact
      t.boolean :account_holder

      t.timestamps
    end
  end
end
