class LessonsController < ApplicationController
  include LessonQueryHelper

  before_action :set_lesson, only: %i[ show edit update destroy ]

  # GET /lessons or /lessons.json
  def index
    @lesson_schedule = lessons_by_venue_by_day(other_includes: [:tutor])
  end

  # GET /lessons/1 or /lessons/1.json
  def show
    @lesson_members = LessonMember.includes(:student)
                                  .where(lesson_id: @lesson.id)
                                  .order(
                                    "students.last_name",
                                    "students.first_name"
                                  )
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons or /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to lesson_url(@lesson), notice: "Lesson was successfully created." }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1 or /lessons/1.json
  def update
    respond_to do |format|
      if Lesson.new(lesson_params) == @lesson
        format.html do
          redirect_to lesson_url(@lesson), alert: 'No changes made to lesson.'
        end
      elsif @lesson.update(lesson_params)
        format.html { redirect_to lesson_url(@lesson), notice: "Lesson was successfully updated." }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1 or /lessons/1.json
  def destroy
    respond_to do |format|
      if @lesson.destroy
        format.html { redirect_to lessons_url, notice: "Lesson was successfully destroyed." }
        format.json { head :no_content }
      else
        set_flash_alert_with_errors_of(@lesson)
        format.html { redirect_to lesson_url(@lesson) }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:tutor_id, :venue_id, :week_day_index, :start_time, :capacity, :standard_price, :duration)
    end
end