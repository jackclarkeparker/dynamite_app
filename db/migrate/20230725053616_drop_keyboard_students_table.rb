class DropKeyboardStudentsTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :keyboard_students
  end

  def down
    create_table :keyboard_students do |t|
      t.references :student, null: false, foreign_key: true
      t.string :keyboard

      t.timestamps
    end
  end
end
