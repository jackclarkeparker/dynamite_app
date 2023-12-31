class Lesson < ApplicationRecord
  include RelatedModelValidator

  belongs_to :tutor, optional: true
  belongs_to :venue, optional: true

  has_many :lesson_members
  has_many :students, through: :lesson_members

  before_destroy :destroy_inactive_lesson_members

  before_validation :set_end_time

  validates :standard_price, :capacity, :duration,
            :start_time, presence: true
  validate :validate_venue_id
  validate :validate_tutor_id
  validate :validate_day
  validates :standard_price, numericality: {
    in: 1..50, message: "must be no less than 1, and no greater than 50"
  }, allow_blank: true
  validates :capacity, numericality: {
    in: 1..6, message: "must be no less than 1, and no greater than 6"
  }, allow_blank: true

  validate :validate_tutor_clash
  validate :validate_venue_clash

  def ==(other_lesson)
    self.venue_id == other_lesson.venue_id &&
    self.tutor_id == other_lesson.tutor_id &&
    self.week_day_index == other_lesson.week_day_index &&
    self.start_time == other_lesson.start_time &&
    self.duration == other_lesson.duration &&
    self.capacity == other_lesson.capacity &&
    self.standard_price == other_lesson.standard_price
  end

  def availability
    capacity - lesson_members_count
  end

  def day
    Date::DAYNAMES[self.week_day_index]
  end

  def formatted_start_time
    start_time.strftime("%-l:%M%P")
  end

  def formatted_end_time
    end_time.strftime("%-l:%M%P")
  end

  def to_s
    "#{formatted_start_time} #{day}s at #{venue.name}"
  end

  private

    def validate_day
      unless week_day_index && week_day_index.between?(0, 6)
        errors.add(:day, "must be selected")
      end
    end

    def set_end_time
      if start_time && duration
        seconds_per_minute = 60
        self.end_time = start_time + (duration * seconds_per_minute)
      end
    end

    def validate_tutor_clash
      lessons_to_check = Lesson.where(
        tutor_id: tutor_id, week_day_index: week_day_index
      ).reject { |lesson| lesson.id == self.id }

      is_a_clash = lessons_to_check.any? do |existing|
        (existing.start_time...existing.end_time).cover?(self.start_time) ||
        ((existing.start_time + 1)..existing.end_time).cover?(self.end_time)
      end

      if is_a_clash
        errors.add(:tutor, "is already teaching during this timeslot")
      end
    end

    def validate_venue_clash
      lessons_to_check = Lesson.where(
        venue_id: venue_id, week_day_index: week_day_index
      ).reject { |lesson| lesson.id == self.id }

      is_a_clash = lessons_to_check.any? do |existing|
        (existing.start_time...existing.end_time).cover?(self.start_time) ||
        ((existing.start_time + 1)..existing.end_time).cover?(self.end_time)
      end

      if is_a_clash
        errors.add(:venue, "is already being used during this timeslot")
      end
    end

    def destroy_inactive_lesson_members
      inactives = LessonMember.unscoped.where(
        "valid_until != ?", FUTURE_EPOCH
      ).where(lesson_id: self.id)

      inactives.each(&:destroy)
    end
end
