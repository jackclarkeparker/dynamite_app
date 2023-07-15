module LessonsHelper
  def display_start_time(lesson)
    lesson.start_time.strftime("%-l:%M%P")
  end
end
