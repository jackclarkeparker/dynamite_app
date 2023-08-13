class Booking < ApplicationRecord
  belongs_to :lesson
  belongs_to :contact
end
