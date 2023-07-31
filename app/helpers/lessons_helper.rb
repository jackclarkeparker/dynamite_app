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
    lesson.formatted_start_time + ' - ' + lesson.formatted_end_time
  end
end
