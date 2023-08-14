class BookingsController < ApplicationController
  include LessonQueryHelper

  def lessons
    @lesson_schedule = lessons_by_venue_by_day
  end

  def new_booking
  end

  def new_waiting_list_entry
  end
end
