class UniqueTutorPhoneAndEmailValidator < ActiveModel::Validator
  def validate(record)
    other_active_tutors = Tutor.all.select do |t|
      t.valid_until == ApplicationRecord::FUTURE_EPOCH
    end.reject { |t| t.id == record.id }

    if other_active_tutors.any? { |t| t.email_address == record.email_address }
      record.errors.add :base, "Email address in use by another tutor"
    end

    if other_active_tutors.any? { |t| t.phone_number == record.phone_number }
      record.errors.add :base, "Phone number in use by another tutor"
    end
  end
end
