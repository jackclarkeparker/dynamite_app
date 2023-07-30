class Student < ApplicationRecord
  include RelatedModelValidator

  belongs_to :region, optional: true

  # has_many :lesson_members
  # has_many :student_contacts

  validates :first_name, :last_name, :gender, :age, presence: true
  validates :age, numericality: { greater_than: 2 }, allow_blank: true

  validate :validate_region_id
  validates :year_group, numericality: {
    in: 1..13, message: "must be no less than 1, and no greater than 13"
  }, allow_blank: true
  validate :validate_birthday_at_least_two_years_ago

  before_create :set_full_name

  def ==(other_student)
    self.region_id == other_student.region_id &&
    self.first_name == other_student.first_name &&
    self.preferred_name == other_student.preferred_name &&
    self.last_name == other_student.last_name &&
    self.year_group == other_student.year_group &&
    self.age == other_student.age &&
    self.birthday == other_student.birthday &&
    self.gender == other_student.gender &&
    self.keyboard == other_student.keyboard
  end

  private

    def validate_birthday_at_least_two_years_ago
      if birthday && birthday >= two_years_ago
        errors.add(:birthday, "can't be less than two years ago")
      end
    end

    def two_years_ago
      today = Date.today
      day = today.day
      month = today.month
      year = today.year - 2

      Date.new(year, month, day)
    end

    def set_full_name
      self.full_name = "#{self.first_name} #{self.last_name}"
    end
end
