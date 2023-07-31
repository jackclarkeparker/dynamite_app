class StudentContact < ApplicationRecord
  belongs_to :students
  belongs_to :contacts
end
