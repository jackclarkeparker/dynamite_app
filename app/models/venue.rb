class Venue < ApplicationRecord
  belongs_to :region
  has_many :lessons
end
