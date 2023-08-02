class StudentContactsController < ApplicationController
  before_action :set_student_with_student_contacts, only: [
    :new_contact_relationship, :create_contact_relationship,
    :edit_contact_relationship, :update_contact_relationship,
  ]

  # GET /students/1/new_contact
  def new_contact_relationship
    @student_contact = StudentContact.new(student_id: @student.id)
  end

  def new_student_relationship
  end

  def edit_contact_relationship
    @student_contact = StudentContact.find_by(
      student_id: params[:student_id],
      contact_id: params[:contact_id],
    )
  end

  def edit_student_relationship
  end

  # POST /students/1/assign_contact
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

  def destroy_contact_relationship
  end

  private

    def set_student_with_student_contacts
      @student = Student.includes(:student_contacts).find(params[:student_id])
    end

    def student_contact_params
      params.require(:student_contact).permit(:student_id, :contact_id, :contact_relation, :primary_contact, :account_holder)
    end
end
