class StudentContact < ApplicationRecord
  belongs_to :student
  belongs_to :contact
end
