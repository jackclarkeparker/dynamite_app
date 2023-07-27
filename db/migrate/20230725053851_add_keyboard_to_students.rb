class AddKeyboardToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :keyboard, :string
  end
end
