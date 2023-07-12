class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :preferred_name
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.integer :year_group
      t.string :gender
      t.references :region, null: false, foreign_key: true

      t.timestamps
    end
  end
end
