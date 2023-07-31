class RenameMistakenColumnsInStudentContacts < ActiveRecord::Migration[7.0]
  def change
    rename_column :student_contacts, :students_id, :student_id
    rename_column :student_contacts, :contacts_id, :contact_id
  end
end
