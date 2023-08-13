class AddLessonMembersCountToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :lesson_members_count, :integer, default: 0
  end
end
