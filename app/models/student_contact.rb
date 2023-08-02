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
end
