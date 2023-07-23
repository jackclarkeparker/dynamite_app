class Lesson < ApplicationRecord
  include RelatedModelValidator

  belongs_to :tutor, optional: true
  belongs_to :venue, optional: true

  after_initialize :set_end_time

  validate :validate_venue_id
  validate :validate_tutor_id

  def day
    Date::DAYNAMES[self.week_day_index]
  end

  private

    def set_end_time
      if start_time && duration
        seconds_per_minute = 60
        self.end_time = start_time + (duration * seconds_per_minute)
      end
    end
end
