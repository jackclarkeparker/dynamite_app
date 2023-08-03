class StudentContact < ApplicationRecord
  include RelatedModelValidator

  belongs_to :student, optional: true
  belongs_to :contact, optional: true

  validate :validate_student_id
  validate :validate_contact_id
  validates :primary_contact, inclusion: {
    in: [true, false],
    message: "must be selected"
  }

  def ==(other_student_contact)
    student_id == other_student_contact.student_id &&
    contact_id == other_student_contact.contact_id &&
    contact_relation == other_student_contact.contact_relation &&
    primary_contact == other_student_contact.primary_contact &&
    account_holder == other_student_contact.account_holder
  end
end
