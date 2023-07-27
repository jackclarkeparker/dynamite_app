class Venue < ApplicationRecord
  include RelatedModelValidator

  belongs_to :region, optional: true
  has_many :lessons

  validates :name, :address, presence: true
  validates :name, :address, uniqueness: true

  validate :validate_region_id

  before_destroy :ensure_no_active_lessons


  private

    def ensure_no_active_lessons
      if lessons.any?
        errors.add(:base, "Venue can't be destroyed; lessons are still active")
        throw :abort
      end
    end
end
