class SetDurationTo30ForExistingLessons < ActiveRecord::Migration[7.0]
  def up
    Lesson.all.each do |lesson|
      lesson.duration = 30
      lesson.save!
    end
  end

  def down
    Lesson.all.each do |lesson|
      lesson.duration = nil
      lesson.save!
    end
  end
end
