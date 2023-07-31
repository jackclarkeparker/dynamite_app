class RenameRelationToContactRelationInStudentContacts < ActiveRecord::Migration[7.0]
  def change
    rename_column :student_contacts, :relation, :contact_relation
  end
end
