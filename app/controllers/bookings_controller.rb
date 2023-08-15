class BookingsController < ApplicationController
  include LessonQueryHelper
  before_action :set_lesson_and_region_ids, only: %i[ new_booking create_booking ]

  def lessons
    @lesson_schedule = lessons_by_venue_by_day
  end

  def new_booking
    @booking = Booking.new
  end

  def create_booking
    contact = Booking.contact_from_booking_params(booking_params)
    student = Booking.student_from_booking_params(booking_params)

    # contact.insert!
    # student.insert!

    # LessonMember.create(lesson_id: @lesson_id, student_id: student.id)
  end

  # def create
  #   @lesson = Lesson.new(lesson_params)

  #   respond_to do |format|
  #     if @lesson.save
  #       format.html { redirect_to lesson_url(@lesson), notice: "Lesson was successfully created." }
  #       format.json { render :show, status: :created, location: @lesson }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @lesson.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def new_waiting_list_entry
  end

  private

    def region_id_from_lesson_id(region_id)
      Lesson.joins(:venue).where("lessons.id" => region_id)
                          .pluck(:region_id).first
    end

    def set_lesson_and_region_ids
      @lesson_id = params[:lesson_id]
      @region_id = region_id_from_lesson_id(@lesson_id)
    end

    def booking_params
      params.require(:booking).permit(:student_name, :student_age, :contact_name, :contact_email, :contact_phone, :additional_details, :lesson_id, :region_id)
    end
end
