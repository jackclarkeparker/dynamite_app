class Venue < ApplicationRecord
  belongs_to :region
  has_many :lessons

  validates :region_id, :name, :address, presence: true
  validates :name, :address, uniqueness: true
end
