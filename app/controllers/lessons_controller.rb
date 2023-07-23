class LessonsController < ApplicationController
  include EntityHelpers

  before_action :set_lesson, only: %i[ show edit update destroy ]

  # GET /lessons or /lessons.json
  def index
    @lesson_schedule = Lesson.includes(:venue, :tutor).order(
      :venue_id, :week_day_index, :start_time
    ).reduce({}) do |schedule, l|
      schedule[l.venue.name] ||= {}
      schedule[l.venue.name][l.day] ||= []
      schedule[l.venue.name][l.day] << l
      schedule
    end
  end

  def booker
    @lesson_schedule = Lesson.includes(:venue).order(
      :venue_id, :week_day_index, :start_time
    ).reduce({}) do |schedule, l|
      schedule[l.venue.name] ||= {}
      schedule[l.venue.name][l.day] ||= []
      schedule[l.venue.name][l.day] << l
      schedule
    end

    # What do we need to do to have the venues displayed in
    # alphabetical order?
    # Also, this implementation still doesn't handle regions
  end

  # GET /lessons/1 or /lessons/1.json
  def show
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
    @lesson.availability = @lesson.capacity

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
      if @lesson.update(lesson_params)
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
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to lessons_url, notice: "Lesson was successfully destroyed." }
      format.json { head :no_content }
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
