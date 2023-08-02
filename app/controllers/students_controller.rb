class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]
  before_action :set_student_with_student_contacts, only: %i[ new_contact assign_contact ]

  # GET /students or /students.json
  def index
    # Include :school in join table when we add this
    @students_by_region = Student.includes(:region, { student_contacts: :contact })
                                 .order(:region_id, :last_name, :first_name)
                                 .reduce({}) do |dictionary, student|
                                   dictionary[student.region.name] ||= []
                                   dictionary[student.region.name] << student
                                   dictionary
                                 end
  end

  # GET /students/1 or /students/1.json
  def show
    @student = Student.includes(:region, { student_contacts: :contact })
                      .order(:primary_contact, "contacts.first_name")
                      .find(params[:id])
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

  # GET /students/1/new_contact
  def new_contact
    @student_contact = StudentContact.new(student_id: @student.id)
  end

  # POST /students/1/assign_contact
  def assign_contact
    @student_contact = StudentContact.new(student_contact_params)

    respond_to do |format|
      if @student_contact.save
        format.html { redirect_to student_url(@student), notice: "Contact was successfully added." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new_contact, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    def set_student_with_student_contacts
      @student = Student.includes(:student_contacts).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:preferred_name, :first_name, :last_name, :birthday, :year_group, :gender, :region_id, :keyboard, :age)
    end

    def student_contact_params
      params.require(:student_contact).permit(:student_id, :contact_id, :contact_relation, :primary_contact, :account_holder)
    end
end
