class AddFullNameToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :full_name, :string
  end
end
