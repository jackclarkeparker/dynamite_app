class Student < ApplicationRecord
  include RelatedModelValidator

  belongs_to :region, optional: true

  has_many :lesson_members
  has_many :student_contacts

  validates :first_name, :age, presence: true
  validates :age, numericality: {
    greater_than: 3,
    message: 'must be greater than three'
  }, allow_blank: true

  validate :validate_region_id
  validates :year_group, numericality: {
    in: 1..13, message: "cannot be less than 1, or greater than 13"
  }, allow_blank: true
  validate :validate_birthday_at_least_two_years_ago
  validates :gender, inclusion: {
    in: %w(Gender male female other),
    message: "must be selected"
  }, allow_blank: true

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

  def contacts
    student_contacts.map(&:contact)
  end

  def to_s
    if preferred_name && preferred_name.length > 0
      preferred_name
    else
      first_name
    end
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
      self.full_name = first_name
      self.full_name += " #{last_name}" if last_name && last_name.length > 0
    end
end
