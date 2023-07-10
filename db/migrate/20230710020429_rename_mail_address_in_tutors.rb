class RenameMailAddressInTutors < ActiveRecord::Migration[7.0]
  def change
    rename_column :tutors, :mail_address, :delivery_address
  end
end
