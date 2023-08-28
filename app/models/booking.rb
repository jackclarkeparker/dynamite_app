class Booking < ApplicationRecord
  belongs_to :lesson
  belongs_to :contact, inverse_of: :booking

  has_many :booking_students, inverse_of: :booking
  has_many :students, through: :booking_students

  accepts_nested_attributes_for :contact, :students
  # validates_associated :contact#, :students

  # validates :contact, presence: true
  # validates :students <Not empty>
  # Maybe the validations will be taken care of by Student already.
  # In that case, we do need to create the students before creating the
  # booking

  # With inverse_of, the 

  # before_validation :build_contact_and_student

  def students_attributes=(attributes)
    students.build(attributes)
  end

  def contact_attributes=(attributes)
    build_contact(attributes)
  end

  private

    def build_contact_and_student
      # Student.skip_callback(:create, :before, :set_full_name)
      # Contact.skip_callback(:create, :before, :set_full_name)

      debugger
      # puts 'hello' * 1000

      build_student(attributes_for_student)
      build_contact(attributes_for_contact)

      Student.set_callback(:create, :before, :set_full_name)
      Contact.set_callback(:create, :before, :set_full_name)
    end

    def with_first_and_last_name(attributes)
      first, last = first_last_from_full_name(attributes[:full_name])
      attributes.merge(first_name: first, last_name: last)
    end

    def set_form_inputs_in(attributes)
    end

    def first_last_from_full_name(full_name)
      name_parts = full_name.strip.split(' ')

      first = name_parts[0]
      last = name_parts.length > 1 ? name_parts[-1] : nil

      [ first, last ]
    end

  # def self.contact_from_booking_params(booking_params)
  #   region_id = booking_params[:region_id]
  #   contact_params = booking_params.select do |param, _|
  #     param.start_with?('contact')
  #   end

  #   first, last = first_last_from_name(contact_params[:contact_name])

  #   Contact.new(
  #     first_name: first,
  #     last_name: last,
  #     full_name: contact_params[:contact_name],
  #     region_id: region_id,
  #     email_address: contact_params[:contact_email],
  #     phone_number: contact_params[:phone_number],
  #   )
  # end

  # def self.student_from_booking_params(booking_params)
  #   region_id = booking_params[:region_id]
  #   student_params = booking_params.select do |param, _|
  #     param.start_with?('student')
  #   end
  #   first, last = first_last_from_name(student_params[:student_name])

  #   Student.new(
  #     region_id: region_id,
  #     first_name: first,
  #     last_name: last,
  #     full_name: student_params[:student_name],
  #     age: student_params[:student_age],
  #   )
  # end

  # private

  #   def self.first_last_from_name(name)
  #     name_components = name.split(' ')

  #     if name_components.length > 1
  #       [ name_components[0], name_components[-1] ]
  #     else
  #       [ name_components[0], nil ]
  #     end
  #   end
end
