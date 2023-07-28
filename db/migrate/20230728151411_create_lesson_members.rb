class CreateLessonMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :lesson_members do |t|
      t.references :lesson, null: false, foreign_key: true
      t.references :student, null: true, foreign_key: true
      t.datetime :valid_until

      t.timestamps
    end
  end
end
