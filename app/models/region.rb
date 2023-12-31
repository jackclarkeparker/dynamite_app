class Region < ApplicationRecord
  has_many :venues
  has_many :tutors
  has_many :students
  has_many :contacts

  validates :name, presence: true, uniqueness: true

  def ==(other_region)
    name == other_region.name
  end

  def to_s
    name
  end
end
