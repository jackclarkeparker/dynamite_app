class BookingStudent < ApplicationRecord
  belongs_to :booking, inverse_of: :booking_students
  belongs_to :student, inverse_of: :booking_students

  # validates :booking, presence: true ? Something like this in the article.
end
