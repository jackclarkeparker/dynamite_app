class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    # Include :school in join table when we add this
    @students_by_region = Student.includes(:region).order(
      :region_id, :first_name
    ).reduce({}) do |register, student|
      register[student.region.name] ||= []
      register[student.region.name] << student
      register
    end
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if Student.new(student_params) == @student
        format.html do
          redirect_to student_url(@student), alert: "No changes made to student."
        end
      elsif @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    respond_to do |format|
      if @student.destroy
        format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
        format.json { head :no_content }
      else
        set_flash_alert_with_errors_of(@student)
        format.html { redirect_to student_url(@student) }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:preferred_name, :first_name, :last_name, :birthday, :year_group, :gender, :region_id, :keyboard)
    end
end
