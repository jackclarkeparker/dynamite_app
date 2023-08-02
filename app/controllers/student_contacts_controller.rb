class StudentContactsController < ApplicationController
  before_action :set_student_with_student_contacts, only: [
    :new_contact_relationship, :create_contact_relationship,
    :edit_contact_relationship, :update_contact_relationship,
  ]

  # GET /students/1/contacts/new
  def new_contact_relationship
    @student_contact = StudentContact.new(student_id: @student.id)
  end

  # GET /students/1/contacts/1/edit
  def edit_contact_relationship
    @student_contact = StudentContact.find_by(
      student_id: params[:student_id],
      contact_id: params[:contact_id],
    )
  end

  # POST /students/1/contacts
  def create_contact_relationship
    @student_contact = StudentContact.new(student_contact_params)

    respond_to do |format|
      if @student_contact.save
        format.html { redirect_to student_url(@student), notice: "Contact was successfully added." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new_contact_relationship, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH /students/1/contacts/1
  def update_contact_relationship
  end

  # DELETE /students/1/contacts/1
  def destroy_contact_relationship
  end

  # GET /contacts/1/students/new
  def new_student_relationship
  end

  # GET /students/1/contacts/1/edit
  def edit_student_relationship
  end

  # POST /contacts/1/students
  def create_student_relationship
  end

  # PATCH /contacts/1/students/1
  def update_student_relationship
  end

  # DELETE /contacts/1/students/1
  def destroy_student_relationship
  end

  private

    def set_student_with_student_contacts
      @student = Student.includes(:student_contacts).find(params[:student_id])
    end

    def student_contact_params
      params.require(:student_contact).permit(:student_id, :contact_id, :contact_relation, :primary_contact, :account_holder)
    end
end
