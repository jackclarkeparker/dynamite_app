module LessonsHelper
  def default_start_time
    params[:lesson] && params[:lesson][:start_time] ||
    @lesson && @lesson.start_time && @lesson.start_time.strftime("%H:%M:%S")
  end

  def default_capacity
    params[:lesson] && params[:lesson][:capacity] ||
    @lesson && @lesson.capacity || 4
  end

  def default_duration
    params[:lesson] && params[:lesson][:duration] ||
    @lesson && @lesson.duration || 30
  end

  def display_lesson_time_range(lesson)
    display_start_time(lesson) + ' - ' + display_end_time(lesson)
  end

  def display_end_time(lesson)
    lesson.end_time.strftime("%-l:%M%P")
  end

  def display_start_time(lesson)
    lesson.start_time.strftime("%-l:%M%P")
  end
end
