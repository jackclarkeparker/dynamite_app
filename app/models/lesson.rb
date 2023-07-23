class Lesson < ApplicationRecord
  include RelatedModelValidator

  belongs_to :tutor, optional: true
  belongs_to :venue, optional: true

  validate :validate_venue_id
  validate :validate_tutor_id

  def day
    Date::DAYNAMES[self.week_day_index]
  end
end
