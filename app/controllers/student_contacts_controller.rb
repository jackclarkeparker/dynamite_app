class StudentContactsController < ApplicationController
  before_action :set_student_with_student_contacts, only: %i[ new_contact assign_contact ]

  # GET /students/1/new_contact
  def new_contact
    @student_contact = StudentContact.new(student_id: @student.id)
  end

  def new_student
  end

  def edit_contact
  end

  def edit_student
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

    def set_student_with_student_contacts
      @student = Student.includes(:student_contacts).find(params[:id])
    end

    def student_contact_params
      params.require(:student_contact).permit(:student_id, :contact_id, :contact_relation, :primary_contact, :account_holder)
    end
end
