class Booking < ApplicationRecord
  belongs_to :lesson
  belongs_to :contact

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
