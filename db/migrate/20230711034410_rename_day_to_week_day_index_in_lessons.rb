class RenameDayToWeekDayIndexInLessons < ActiveRecord::Migration[7.0]
  def change
    rename_column :lessons, :day, :week_day_index
  end
end
