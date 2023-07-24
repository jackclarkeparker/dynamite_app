class Student < ApplicationRecord
  include RelatedModelValidator

  belongs_to :region, optional: true

  validates :first_name, :last_name, :gender, presence: true

  validate :validate_region_id
  validates :region_id, numericality: {
    in: 1..13, message: "Must be no less than 1, and no greater than 13"
  }, allow_blank: true

  def self.two_years_ago
    today = Date.today
    day = today.day
    month = today.month
    year = today.year - 2

    Date.new(year, month, day)
  end

  validates :birthday, comparison: {
    less_than: two_years_ago, message: "must be more than two years ago"
  }
end
