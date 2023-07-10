class Venue < ApplicationRecord
  def region
    Region.find(self.region_id)
  end
end
