class Lesson < ApplicationRecord
  belongs_to :tutor
  belongs_to :venue

  def day
    Date::DAYNAMES[self.week_day_index]
  end
end
