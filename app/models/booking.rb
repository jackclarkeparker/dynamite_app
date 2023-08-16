class Booking < ApplicationRecord
  belongs_to :lesson
  belongs_to :contact

  # has_many :students, through: :booking_students

  # I think we'll want to set this to :students instead of :student
  # once the booking form allows more than one student to be booked.
  # accepts_nested_attributes_for :contact, :student

  def student_attributes=(attributes)
    processed_student_attributes = process_name(attributes)
    super(processed_student_attributes)
  end

  def contact_attributes=(attributes)
    processed_contact_attributes = process_name(attributes)
    super(processed_contact_attributes)
  end

  private

    def process_name(attributes)
      full_name = attributes[:full_name]
      first_name, last_name = first_last_from_full_name(full_name)
      attributes.merge(first_name: first_name, last_name: last_name)
    end

    def first_last_from_full_name(full_name)
      name_parts = full_name.split(' ')

      first = name_parts[0]
      last = name_parts.length > 1 ? name_parts[-1] : nil

      [ first, last ]
    end

  def self.contact_from_booking_params(booking_params)
    region_id = booking_params[:region_id]
    contact_params = booking_params.select do |param, _|
      param.start_with?('contact')
    end

    first, last = first_last_from_name(contact_params[:contact_name])

    Contact.new(
      first_name: first,
      last_name: last,
      full_name: contact_params[:contact_name],
      region_id: region_id,
      email_address: contact_params[:contact_email],
      phone_number: contact_params[:phone_number],
    )
  end

  def self.student_from_booking_params(booking_params)
    region_id = booking_params[:region_id]
    student_params = booking_params.select do |param, _|
      param.start_with?('student')
    end
    first, last = first_last_from_name(student_params[:student_name])

    Student.new(
      region_id: region_id,
      first_name: first,
      last_name: last,
      full_name: student_params[:student_name],
      age: student_params[:student_age],
    )
  end

  private

    def self.first_last_from_name(name)
      name_components = name.split(' ')

      if name_components.length > 1
        [ name_components[0], name_components[-1] ]
      else
        [ name_components[0], nil ]
      end
    end
end
