class BookingStudent < ApplicationRecord
  belongs_to :booking
  belongs_to :student
end
