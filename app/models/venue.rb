class Venue < ApplicationRecord
  include RelatedModelValidator

  belongs_to :region, optional: true
  has_many :lessons

  validates :name, :address, presence: true
  validates :name, :address, uniqueness: true

  validate :validate_region_id
end
