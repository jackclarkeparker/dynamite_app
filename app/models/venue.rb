class Venue < ApplicationRecord
  include RelatedModelValidator

  belongs_to :region, optional: true
  has_many :lessons

  validates :name, :address, :standard_price, presence: true
  validates :address, uniqueness: { message: 'in use by another venue' }
  validate :validate_region_id
  validate :validate_name_unique_to_region

  before_destroy :ensure_no_active_lessons

  def ==(other_venue)
    self.region_id == other_venue.region_id &&
    self.name == other_venue.name &&
    self.address == other_venue.address &&
    self.standard_price == other_venue.standard_price
  end

  def to_s
    name
  end

  private

    def validate_name_unique_to_region
      if Region.exists?(id: region_id)
        region = Region.find(region_id)
        if region.venues.any? { |v| v.name == name }
          errors.add(:name, "already used by another venue in this region")
        end
      end
    end

    def ensure_no_active_lessons
      if lessons.any?
        errors.add(:base, "Venue can't be destroyed; lessons are still active")
        throw :abort
      end
    end
end
