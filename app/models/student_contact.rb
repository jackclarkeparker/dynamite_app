class StudentContact < ApplicationRecord
  include RelatedModelValidator

  belongs_to :student, optional: true
  belongs_to :contact, optional: true

  validate :validate_student_id
  validate :validate_contact_id
  validate :validate_new_combination
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

  private

    def validate_new_combination
      existing_student_contacts = StudentContact.all.reject do |student_contact|
        student_contact.id == self.id
      end

      combo_in_use = existing_student_contacts.any? do |student_contact|
        student_contact.student_id == self.student_id &&
        student_contact.contact_id == self.contact_id
      end

      if combo_in_use
        errors.add(:student, 'must be selected')
        errors.add(:contact, 'must be selected')
      end
    end
end
