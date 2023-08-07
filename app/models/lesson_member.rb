class LessonMember < ApplicationRecord
  include RelatedModelValidator

  belongs_to :lesson, optional: true
  belongs_to :student, optional: true

  default_scope { where(valid_until: FUTURE_EPOCH) }

  validate :validate_student_id
  validate :validate_lesson_id
  validate :validate_new_combination

  private

    def validate_new_combination
      existing_lesson_members = LessonMember.all.reject { |lm| lm.id == self.id }
      combination_already_in_use = existing_lesson_members.any? do |lm|
        lm.lesson_id == self.lesson_id && lm.student_id == self.student_id
      end

      if combination_already_in_use
        errors.add(:lesson, 'must be selected')
        errors.add(:student, 'must be selected')
      end
    end
end
