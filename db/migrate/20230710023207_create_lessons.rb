class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.references :tutor, null: false, foreign_key: true
      t.references :venue, null: false, foreign_key: true
      t.integer :day
      t.time :start_time
      t.integer :capacity
      t.integer :standard_price

      t.timestamps
    end
  end
end
