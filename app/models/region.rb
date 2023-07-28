class Region < ApplicationRecord
  include NotReferencedBeforeDestroy

  has_many :venues
  has_many :tutors
  has_many :students

  validates :name, presence: true, uniqueness: true

  def ==(other_region)
    name == other_region.name
  end

  def to_s
    name
  end
end
