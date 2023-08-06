class LessonMember < ApplicationRecord
  belongs_to :lesson
  belongs_to :student

  default_scope { where(valid_until: FUTURE_EPOCH) }
end
