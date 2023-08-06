class LessonMember < ApplicationRecord
  belongs_to :lesson
  belongs_to :student

  before_create :set_valid_until

  private

    def set_valid_until
      self.valid_until = FUTURE_EPOCH
    end
end
