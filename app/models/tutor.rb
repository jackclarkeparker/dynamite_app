class UniqueTutorPhoneAndEmailValidator < ActiveModel::Validator
  def validate(record)
    other_active_tutors = Tutor.all.select do |t|
      t.valid_until == ApplicationRecord::FUTURE_EPOCH
    end.reject { |t| t.entity_id == record.entity_id }

    if other_active_tutors.any? { |t| t.email_address == record.email_address }
      record.errors.add :base, "Email address in use by another tutor"
    end

    if other_active_tutors.any? { |t| t.phone_number == record.phone_number }
      record.errors.add :base, "Phone number in use by another tutor"
    end
  end
end

class Tutor < ApplicationRecord
  has_many :lessons

  validates :first_name, :last_name, :email_address,
            :phone_number, :delivery_address,
            :entity_id, presence: true
  
  # No two active tutors with same email address, or phone number.
  validates_with UniqueTutorPhoneAndEmailValidator

  before_create :set_full_name_and_valid_until

  def same_attributes_as(other_tutor)
    self.preferred_name == other_tutor.preferred_name &&
    self.first_name == other_tutor.first_name &&
    self.last_name == other_tutor.last_name &&
    self.email_address == other_tutor.email_address &&
    self.phone_number == other_tutor.phone_number &&
    self.delivery_address == other_tutor.delivery_address
  end

  def to_s
    if self.preferred_name && self.preferred_name.length > 0
      self.preferred_name
    else
      self.first_name
    end
  end

  private

    def set_full_name_and_valid_until
      self.full_name = "#{self.first_name} #{self.last_name}"
      self.valid_until = ApplicationRecord::FUTURE_EPOCH
    end
end
