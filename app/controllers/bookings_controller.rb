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
    @booking = Booking.new(booking_params)

    debugger

    # contact = Booking.contact_from_booking_params(booking_params)
    # student = Booking.student_from_booking_params(booking_params)

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
      params.require(:booking).permit(
        :additional_details, :lesson_id,
        student_attributes: [:full_name, :age, :region_id],
        contact_attributes: [:full_name, :email_address, :phone_number, :region_id]
      )
    end
end
