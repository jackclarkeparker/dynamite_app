class AddEndTimeToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :end_time, :time
  end
end
