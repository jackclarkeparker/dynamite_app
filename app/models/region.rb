class Region < ApplicationRecord
  has_many :venues
  has_many :tutors
  has_many :students

  validates :name, presence: true, uniqueness: true
end
