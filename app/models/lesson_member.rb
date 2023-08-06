class LessonMember < ApplicationRecord
  include RelatedModelValidator

  belongs_to :lesson
  belongs_to :student, optional: true

  default_scope { where(valid_until: FUTURE_EPOCH) }

  validate :validate_student_id
end
