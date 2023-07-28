class Contact < ApplicationRecord
  # has_many :student_contacts

  validates :first_name, :email_address, presence: true
end
