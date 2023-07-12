class AddFullNameToTutors < ActiveRecord::Migration[7.0]
  def change
    add_column :tutors, :full_name, :string
  end
end
